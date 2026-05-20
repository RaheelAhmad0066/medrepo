import 'dart:convert';
import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:flutter/foundation.dart';
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
  Future<ApiResult<void>> sendOtp(String emailOrPhone,
      {required bool isPhone}) async {
    try {
      final strategy =
          isPhone ? clerk.Strategy.phoneCode : clerk.Strategy.emailCode;
      await _clerkAuth.attemptSignIn(
        strategy: strategy,
        identifier: emailOrPhone,
      );
      return const Success(null);
    } catch (e, stack) {
      final errorMsg = e.toString();
      if (errorMsg.contains("Couldn't find your account") ||
          errorMsg.contains("does not exist") ||
          errorMsg.contains("not found")) {
        debugPrint(
            'Account not found for sign-in. Attempting sign-up fallback for $emailOrPhone...');
        try {
          final strategy =
              isPhone ? clerk.Strategy.phoneCode : clerk.Strategy.emailCode;
          if (isPhone) {
            await _clerkAuth.attemptSignUp(
              strategy: strategy,
              phoneNumber: emailOrPhone,
            );
          } else {
            await _clerkAuth.attemptSignUp(
              strategy: strategy,
              emailAddress: emailOrPhone,
            );
          }
          return const Success(null);
        } catch (signUpError, signUpStack) {
          debugPrint(
              'Clerk attemptSignUp Exception: $signUpError\n$signUpStack');
          return FailureResult(AuthFailure(message: signUpError.toString()));
        }
      }
      debugPrint('Clerk sendOtp Exception: $e\n$stack');
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<User>> verifyOtp(String emailOrPhone, String otp,
      {required bool isPhone}) async {
    try {
      final strategy =
          isPhone ? clerk.Strategy.phoneCode : clerk.Strategy.emailCode;
      if (_clerkAuth.isSigningUp) {
        await _clerkAuth.attemptSignUp(
          strategy: strategy,
          code: otp,
        );

        // If sign-up is not completed yet due to missing fields, automatically supply default ones
        var signUp = _clerkAuth.client.signUp;
        if (signUp != null && signUp.status != clerk.Status.complete) {
          debugPrint('verifyOtp: SignUp status is ${signUp.status}. Missing fields: ${signUp.missingFields}');
          String? firstName;
          String? lastName;
          bool? legalAccepted;
          String? password;

          if (signUp.missingFields.contains(clerk.Field.firstName)) {
            firstName = 'User';
          }
          if (signUp.missingFields.contains(clerk.Field.lastName)) {
            lastName = 'MedRep';
          }
          if (signUp.missingFields.contains(clerk.Field.legalAccepted)) {
            legalAccepted = true;
          }
          if (signUp.missingFields.contains(clerk.Field.password)) {
            password = 'MedRepProSecPass123!';
          }

          if (firstName != null || lastName != null || legalAccepted != null || password != null) {
            debugPrint('verifyOtp: Automatically supplying missing fields: firstName=$firstName, lastName=$lastName, legalAccepted=$legalAccepted, password=$password');
            await _clerkAuth.attemptSignUp(
              firstName: firstName,
              lastName: lastName,
              legalAccepted: legalAccepted,
              password: password,
              passwordConfirmation: password,
            );
          }
        }
      } else {
        await _clerkAuth.attemptSignIn(
          strategy: strategy,
          code: otp,
        );
      }

      // Check if user is logged in
      debugPrint('--- CLERK STATE DIAGNOSTICS ---');
      debugPrint('clerkAuth.isSigningUp: ${_clerkAuth.isSigningUp}');
      debugPrint('clerkAuth.isSigningIn: ${_clerkAuth.isSigningIn}');
      debugPrint('clerkAuth.isSignedIn: ${_clerkAuth.isSignedIn}');
      debugPrint(
          'clerkAuth.client.sessions.length: ${_clerkAuth.client.sessions.length}');
      debugPrint(
          'clerkAuth.client.signUp.status: ${_clerkAuth.client.signUp?.status}');
      debugPrint(
          'clerkAuth.client.signUp.createdSessionId: ${_clerkAuth.client.signUp?.createdSessionId}');
      debugPrint(
          'clerkAuth.client.signUp.createdUserId: ${_clerkAuth.client.signUp?.createdUserId}');
      try {
        debugPrint(
            'clerkAuth.client.toJson(): ${jsonEncode(_clerkAuth.client.toJson())}');
      } catch (jsonErr) {
        debugPrint('Failed to serialize client.toJson: $jsonErr');
      }

      var clerkUser = _clerkAuth.client.user;
      if (clerkUser == null) {
        debugPrint(
            'verifyOtp: client.user is null. Refreshing Clerk client...');
        await _clerkAuth.refreshClient();
        clerkUser = _clerkAuth.client.user;
      }

      if (clerkUser == null && _clerkAuth.client.sessions.isNotEmpty) {
        debugPrint(
            'verifyOtp: sessions list is not empty. Activating first session...');
        await _clerkAuth.activate(_clerkAuth.client.sessions.first);
        clerkUser = _clerkAuth.client.user;
      }

      if (clerkUser == null) {
        debugPrint(
            'verifyOtp: clerkUser is still null after activation attempts!');
        return const FailureResult(AuthFailure(
            message: 'Verification succeeded but no user session was found.'));
      }

      // Retrieve and persist session token in secure storage for HTTP Authorization headers
      final sessionToken = await _clerkAuth.sessionToken();
      await _secureStorage.saveAccessToken(sessionToken.jwt);
      await _secureStorage.saveUserId(clerkUser.id);

      final userDto = UserDto.fromJson(clerkUser.toJson());
      await _secureStorage.saveUserRole(userDto.role);
      await _secureStorage.saveTenantId(userDto.tenantId);

      return Success(userDto.toDomain());
    } catch (e, stack) {
      debugPrint('Clerk verifyOtp Exception: $e\n$stack');
      return FailureResult(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<User>> authenticateWithBiometrics() async {
    try {
      final enrolled = await isBiometricEnrolled();
      if (!enrolled) {
        return const FailureResult(
            AuthFailure(message: 'Biometrics is not enrolled on this device.'));
      }

      final authenticated = await _biometricService.authenticate(
        reason: 'Authenticate to access your MedRep Pro dashboard',
      );

      if (!authenticated) {
        return const FailureResult(
            AuthFailure(message: 'Biometric verification failed.'));
      }

      final cachedUserId = await _secureStorage.getUserId();
      if (cachedUserId == null) {
        return const FailureResult(AuthFailure(
            message: 'No authenticated session found. Please log in again.'));
      }

      if (_clerkAuth.isSignedIn) {
        final clerkUser = _clerkAuth.client.user!;
        final sessionToken = await _clerkAuth.sessionToken();
        await _secureStorage.saveAccessToken(sessionToken.jwt);
        final userDto = UserDto.fromJson(clerkUser.toJson());
        return Success(userDto.toDomain());
      } else {
        return const FailureResult(AuthFailure(
            message: 'Clerk session has expired. Please log in with OTP.'));
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
