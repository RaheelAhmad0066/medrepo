import 'package:dio/dio.dart';
import 'package:medrep_pro/config/env/app_env.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';

typedef ClerkTokenProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  final Dio _dio;
  final ClerkTokenProvider? _tokenProvider;

  AuthInterceptor(this._secureStorage, this._dio, [this._tokenProvider]);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? accessToken = await _secureStorage.getAccessToken();

    // Attempt to pull a fresh/active JWT from Clerk if a token provider is available
    if (_tokenProvider != null) {
      try {
        final freshToken = await _tokenProvider();
        if (freshToken != null) {
          accessToken = freshToken;
          await _secureStorage.saveAccessToken(freshToken);
        }
      } catch (_) {
        // Fall back to storage token if Clerk retrieval fails (e.g. offline)
      }
    }

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Set Supabase anon apikey for database gateway
    options.headers['apikey'] = AppEnv.supabaseAnonKey;

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // If the request fails with 401, trigger Clerk token refresh
    if (err.response?.statusCode == 401 && _tokenProvider != null) {
      try {
        final newAccessToken = await _tokenProvider();
        if (newAccessToken != null) {
          await _secureStorage.saveAccessToken(newAccessToken);

          // Retry the original request with the fresh token
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await _dio.fetch(requestOptions);
          return handler.resolve(retryResponse);
        }
      } catch (_) {
        // Clear locally stored tokens if token refresh fails completely
        await _secureStorage.clearAll();
      }
    }
    return handler.next(err);
  }
}
