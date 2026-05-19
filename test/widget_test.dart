import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/main.dart';

class FakeSecureStorageService implements SecureStorageService {
  final Map<String, String> _storage = {};

  @override
  Future<void> saveAccessToken(String token) async => _storage['access_token'] = token;

  @override
  Future<String?> getAccessToken() async => _storage['access_token'];

  @override
  Future<void> saveRefreshToken(String token) async => _storage['refresh_token'] = token;

  @override
  Future<String?> getRefreshToken() async => _storage['refresh_token'];

  @override
  Future<void> saveUserId(String userId) async => _storage['user_id'] = userId;

  @override
  Future<String?> getUserId() async => _storage['user_id'];

  @override
  Future<void> saveUserRole(String role) async => _storage['user_role'] = role;

  @override
  Future<String?> getUserRole() async => _storage['user_role'];

  @override
  Future<void> saveTenantId(String tenantId) async => _storage['tenant_id'] = tenantId;

  @override
  Future<String?> getTenantId() async => _storage['tenant_id'];

  @override
  Future<void> clearAll() async => _storage.clear();
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<ApiResult<User>> authenticateWithBiometrics() async {
    return const Success(User(
      id: '123',
      email: 'test@medrep.com',
      name: 'Test User',
      role: 'medical_rep',
      tenantId: '1',
      territoryIds: [],
    ));
  }

  @override
  Future<ApiResult<User?>> checkAutoLogin() async {
    return const Success(null);
  }

  @override
  Future<ApiResult<String?>> getSessionToken() async {
    return const Success(null);
  }

  @override
  Future<bool> isBiometricEnrolled() async => false;

  @override
  Future<ApiResult<void>> logout() async {
    return const Success(null);
  }

  @override
  Future<ApiResult<void>> sendOtp(String emailOrPhone, {required bool isPhone}) async {
    return const Success(null);
  }

  @override
  Future<void> setBiometricEnrolled({required bool enrolled}) async {}

  @override
  Future<ApiResult<User>> verifyOtp(String emailOrPhone, String otp, {required bool isPhone}) async {
    return const Success(User(
      id: '123',
      email: 'test@medrep.com',
      name: 'Test User',
      role: 'medical_rep',
      tenantId: '1',
      territoryIds: [],
    ));
  }
}

void main() {
  testWidgets('App starts and redirects to login layout', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          secureStorageProvider.overrideWithValue(FakeSecureStorageService()),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
        child: const MedRepProApp(),
      ),
    );

    // Let the GoRouter redirect resolve
    await tester.pumpAndSettle();

    // Verify it loads the login page
    expect(find.textContaining('MedRep Pro'), findsWidgets);
    expect(find.byType(TextFormField), findsWidgets);
  });
}
