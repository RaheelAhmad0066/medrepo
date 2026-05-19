import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/services/session_timer_service.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthStateNotifier(this._repository, this._ref) : super(AuthInitial()) {
    // Listen to inactivity locking events
    _ref.listen<bool>(sessionLockProvider, (previous, locked) {
      if (locked) {
        lockSession();
      }
    });
  }

  /// Initial auto-login check
  Future<void> init() async {
    state = AuthLoading();
    final result = await _repository.checkAutoLogin();
    result.when(
      onSuccess: (user) {
        if (user != null) {
          state = AuthAuthenticated(user);
          _ref.read(sessionTimerServiceProvider).start();
        } else {
          state = AuthInitial();
        }
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }

  /// Send OTP code via Email or Phone
  Future<void> sendOtp(String emailOrPhone, {required bool isPhone}) async {
    state = AuthLoading();
    final result = await _repository.sendOtp(emailOrPhone, isPhone: isPhone);
    result.when(
      onSuccess: (_) {
        state = AuthOtpSent(emailOrPhone, isPhone: isPhone);
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }

  /// Submit OTP verification code
  Future<void> verifyOtp(String otp) async {
    final currentState = state;
    if (currentState is! AuthOtpSent) return;

    state = AuthLoading();
    final result = await _repository.verifyOtp(
      currentState.emailOrPhone,
      otp,
      isPhone: currentState.isPhone,
    );

    result.when(
      onSuccess: (user) {
        state = AuthAuthenticated(user);
        _ref.read(sessionTimerServiceProvider).start();
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }

  /// Authenticate session via local biometrics
  Future<void> authenticateWithBiometrics() async {
    state = AuthLoading();
    final result = await _repository.authenticateWithBiometrics();
    result.when(
      onSuccess: (user) {
        state = AuthAuthenticated(user);
        _ref.read(sessionLockProvider.notifier).state = false;
        _ref.read(sessionTimerServiceProvider).start();
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }

  /// Manually lock the session (e.g. on background or timeout)
  void lockSession() {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      state = AuthSessionLocked(currentState.user);
      _ref.read(sessionTimerServiceProvider).stop();
    }
  }

  /// Unlock screen using biometrics
  Future<void> unlockSessionWithBiometrics() async {
    final currentState = state;
    if (currentState is! AuthSessionLocked) return;

    state = AuthLoading();
    final result = await _repository.authenticateWithBiometrics();
    result.when(
      onSuccess: (user) {
        state = AuthAuthenticated(user);
        _ref.read(sessionLockProvider.notifier).state = false;
        _ref.read(sessionTimerServiceProvider).start();
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }

  /// Log out from Clerk and clear local credentials
  Future<void> logout() async {
    state = AuthLoading();
    final result = await _repository.logout();
    result.when(
      onSuccess: (_) {
        state = AuthInitial();
        _ref.read(sessionLockProvider.notifier).state = false;
        _ref.read(sessionTimerServiceProvider).stop();
      },
      onFailure: (failure) {
        state = AuthError(failure.message);
      },
    );
  }
}

/// Provides the active authentication state.
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final notifier = AuthStateNotifier(repository, ref);
  // Execute initial checks asynchronously after provider is constructed
  Future.microtask(() => notifier.init());
  return notifier;
});
