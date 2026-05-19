import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';
import 'package:medrep_pro/core/services/biometric_service.dart';
import 'package:medrep_pro/features/auth/data/models/user_dto.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final clerk.Auth _clerkAuth;
  final SecureStorageService _secureStorage;
  final BiometricService _biometricService;

  static const String _kBiometricEnrolledKey = 'biometric_enrolled';

  AuthRepositoryImpl({
    required clerk.Auth clerkAuth,
    required SecureStorageService secureStorage,
    required BiometricService biometricService,
  })  : _clerkAuth = clerkAuth,
        _secureStorage = secureStorage,
        _biometricService = biometricService;

  @override
  Future<ApiResult<void>> sendOtp(String emailOrPhone, {required bool isPhone}) async {
    try {
      final strategy = isPhone ? clerk.Strategy.phoneCode : clerk.Strategy.emailCode;
      await _clerkAuth.attemptSignIn(
        strategy: strategy,
        identifier: emailOrPhone,
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<User>> verifyOtp(String emailOrPhone, String otp, {required bool isPhone}) async {
    try {
      final strategy = isPhone ? clerk.Strategy.phoneCode : clerk.Strategy.emailCode;
      await _clerkAuth.attemptSignIn(
        strategy: strategy,
        code: otp,
      );

      final clerkUser = _clerkAuth.client.user;
      if (clerkUser == null) {
        return const FailureResult(AuthFailure(message: 'Verification succeeded but no user session was found.'));
      }

      // Retrieve and persist session token in secure storage for HTTP Authorization headers
      final sessionToken = await _clerkAuth.sessionToken();
      await _secureStorage.saveAccessToken(sessionToken.jwt);
      await _secureStorage.saveUserId(clerkUser.id);

      final userDto = UserDto.fromJson(clerkUser.toJson());
      await _secureStorage.saveUserRole(userDto.role);
      await _secureStorage.saveTenantId(userDto.tenantId);

      return Success(userDto.toDomain());
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<User>> authenticateWithBiometrics() async {
    try {
      final enrolled = await isBiometricEnrolled();
      if (!enrolled) {
        return const FailureResult(AuthFailure(message: 'Biometrics is not enrolled on this device.'));
      }

      final authenticated = await _biometricService.authenticate(
        reason: 'Authenticate to access your MedRep Pro dashboard',
      );

      if (!authenticated) {
        return const FailureResult(AuthFailure(message: 'Biometric verification failed.'));
      }

      final cachedUserId = await _secureStorage.getUserId();
      if (cachedUserId == null) {
        return const FailureResult(AuthFailure(message: 'No authenticated session found. Please log in again.'));
      }

      if (_clerkAuth.isSignedIn) {
        final clerkUser = _clerkAuth.client.user!;
        final sessionToken = await _clerkAuth.sessionToken();
        await _secureStorage.saveAccessToken(sessionToken.jwt);
        final userDto = UserDto.fromJson(clerkUser.toJson());
        return Success(userDto.toDomain());
      } else {
        return const FailureResult(AuthFailure(message: 'Clerk session has expired. Please log in with OTP.'));
      }
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<String?>> getSessionToken() async {
    try {
      if (!_clerkAuth.isSignedIn) {
        return const Success(null);
      }
      final sessionToken = await _clerkAuth.sessionToken();
      await _secureStorage.saveAccessToken(sessionToken.jwt);
      return Success(sessionToken.jwt);
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isBiometricEnrolled() async {
    final cached = await _secureStorage.getUserId();
    if (cached == null) return false;
    final enrollState = await _secureStorage.getRefreshToken();
    return enrollState == _kBiometricEnrolledKey;
  }

  @override
  Future<void> setBiometricEnrolled({required bool enrolled}) async {
    if (enrolled) {
      await _secureStorage.saveRefreshToken(_kBiometricEnrolledKey);
    } else {
      await _secureStorage.saveRefreshToken('');
    }
  }

  @override
  Future<ApiResult<User?>> checkAutoLogin() async {
    try {
      if (_clerkAuth.isSignedIn) {
        final clerkUser = _clerkAuth.client.user!;
        final sessionToken = await _clerkAuth.sessionToken();
        await _secureStorage.saveAccessToken(sessionToken.jwt);
        await _secureStorage.saveUserId(clerkUser.id);

        final userDto = UserDto.fromJson(clerkUser.toJson());
        await _secureStorage.saveUserRole(userDto.role);
        await _secureStorage.saveTenantId(userDto.tenantId);

        return Success(userDto.toDomain());
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      await _clerkAuth.signOut();
      await _secureStorage.clearAll();
      return const Success(null);
    } catch (e) {
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }
}
