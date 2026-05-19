import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Sends an OTP to the specified email address or phone number.
  Future<ApiResult<void>> sendOtp(String emailOrPhone, {required bool isPhone});

  /// Verifies the OTP code sent to the specified email or phone.
  Future<ApiResult<User>> verifyOtp(String emailOrPhone, String otp, {required bool isPhone});

  /// Triggers biometric authentication and verifies the session.
  Future<ApiResult<User>> authenticateWithBiometrics();

  /// Fetches the current session token (JWT) from Clerk.
  Future<ApiResult<String?>> getSessionToken();

  /// Checks if biometrics is enrolled locally.
  Future<bool> isBiometricEnrolled();

  /// Enrolls or dis-enrolls biometrics locally.
  Future<void> setBiometricEnrolled({required bool enrolled});

  /// Verifies if an existing session is valid for auto-login.
  Future<ApiResult<User?>> checkAutoLogin();

  /// Logs the user out.
  Future<ApiResult<void>> logout();
}
