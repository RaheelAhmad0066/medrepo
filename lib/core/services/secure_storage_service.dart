import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medrep_pro/core/constants/app_constants.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: AppConstants.keyAccessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: AppConstants.keyAccessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstants.keyRefreshToken, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: AppConstants.keyRefreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: AppConstants.keyUserId, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: AppConstants.keyUserId);
  }

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: AppConstants.keyUserRole, value: role);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: AppConstants.keyUserRole);
  }

  Future<void> saveTenantId(String tenantId) async {
    await _storage.write(key: AppConstants.keyTenantId, value: tenantId);
  }

  Future<String?> getTenantId() async {
    return await _storage.read(key: AppConstants.keyTenantId);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
