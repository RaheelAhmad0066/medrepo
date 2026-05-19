import 'package:dio/dio.dart';
import 'package:medrep_pro/config/env/app_env.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  final Dio _dio; // Used for retrying requests

  AuthInterceptor(this._secureStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureStorage.getAccessToken();

    // Set common authorization headers
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Since we use Supabase backend, we inject the anon key as standard apikey if not overriding
    options.headers['apikey'] = AppEnv.supabaseAnonKey;

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // If the request failed with 401 (Unauthorized), try to refresh the token
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken != null) {
        try {
          // Perform refresh token request using a clean isolated Dio instance to avoid recursion
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: AppEnv.supabaseUrl,
              headers: {
                'apikey': AppEnv.supabaseAnonKey,
              },
            ),
          );

          final response = await refreshDio.post(
            '/auth/v1/token?grant_type=refresh_token',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final newAccessToken = response.data['access_token'] as String;
            final newRefreshToken = response.data['refresh_token'] as String;

            // Save new tokens
            await _secureStorage.saveAccessToken(newAccessToken);
            await _secureStorage.saveRefreshToken(newRefreshToken);

            // Retry the original request with new token
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await _dio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          }
        } catch (_) {
          // Refresh token is expired or invalid, clear session so routing triggers login redirect
          await _secureStorage.clearAll();
        }
      }
    }
    return handler.next(err);
  }
}
