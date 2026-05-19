import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/error/exceptions.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';
import 'package:medrep_pro/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DioClient _dioClient;
  final SecureStorageService _secureStorage;
  final AppDatabase _db;

  UserRepositoryImpl({
    required DioClient dioClient,
    required SecureStorageService secureStorage,
    required AppDatabase db,
  })  : _dioClient = dioClient,
        _secureStorage = secureStorage,
        _db = db;

  @override
  Future<ApiResult<User>> login(String email, String password) async {
    try {
      final response = await _dioClient.post(
        '/auth/v1/token?grant_type=password',
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data as Map<String, dynamic>;
      final accessToken = responseData['access_token'] as String;
      final refreshToken = responseData['refresh_token'] as String;
      
      final userMap = responseData['user'] as Map<String, dynamic>;
      final userMetadata = userMap['user_metadata'] as Map<String, dynamic>;

      final user = User(
        id: userMap['id'] as String,
        email: userMap['email'] as String,
        name: userMetadata['full_name'] as String? ?? 'Anonymous',
        role: userMetadata['role'] as String? ?? 'sales_rep',
        tenantId: userMetadata['tenant_id'] as String? ?? 'default',
        territoryIds: const [],
      );

      // Save credential states to Secure Storage
      await _secureStorage.saveAccessToken(accessToken);
      await _secureStorage.saveRefreshToken(refreshToken);
      await _secureStorage.saveUserId(user.id);
      await _secureStorage.saveUserRole(user.role);
      await _secureStorage.saveTenantId(user.tenantId);

      // Persist profile response into Cache table for offline access
      await _db.insertOrUpdateCache(
        CachedApiTableCompanion(
          endpointKey: const Value('user_profile'),
          responseJson: Value(jsonEncode(userMap)),
          expiresAt: Value(DateTime.now().add(const Duration(hours: 24))),
        ),
      );

      return Success(user);
    } on AppException catch (e) {
      return FailureResult(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return FailureResult(
        ServerFailure(message: 'Unexpected login error: ${e.toString()}'),
      );
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      await _secureStorage.clearAll();
      await _db.deleteCache('user_profile');
      return const Success(null);
    } catch (e) {
      return const FailureResult(
        CacheFailure(message: 'Error clearing credentials during logout.'),
      );
    }
  }

  @override
  Future<ApiResult<User?>> getCachedProfile() async {
    try {
      final cachedResponse = await _db.getCachedResponse('user_profile');
      if (cachedResponse == null || DateTime.now().isAfter(cachedResponse.expiresAt)) {
        return const Success(null);
      }

      final userMap = jsonDecode(cachedResponse.responseJson) as Map<String, dynamic>;
      final userMetadata = userMap['user_metadata'] as Map<String, dynamic>;

      final user = User(
        id: userMap['id'] as String,
        email: userMap['email'] as String,
        name: userMetadata['full_name'] as String? ?? 'Anonymous',
        role: userMetadata['role'] as String? ?? 'sales_rep',
        tenantId: userMetadata['tenant_id'] as String? ?? 'default',
        territoryIds: const [],
      );

      return Success(user);
    } catch (e) {
      return const FailureResult(
        CacheFailure(message: 'Failed to retrieve cached profile data.'),
      );
    }
  }
}
