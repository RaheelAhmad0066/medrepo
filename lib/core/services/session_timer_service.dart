import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// State provider representing whether the user session is currently locked due to inactivity.
final sessionLockProvider = StateProvider<bool>((ref) => false);

/// Service managing user inactivity timeouts. Reset by user gestures at the root widget tree.
class SessionTimerService {
  final Ref _ref;
  final Duration _timeoutDuration;
  Timer? _timer;
  bool _isRunning = false;

  SessionTimerService(this._ref, {Duration? timeoutDuration})
      : _timeoutDuration = timeoutDuration ?? const Duration(minutes: 15);

  /// Start the inactivity countdown.
  void start() {
    _isRunning = true;
    _resetTimer();
  }

  /// Stop the inactivity countdown.
  void stop() {
    _isRunning = false;
    _timer?.cancel();
  }

  /// Called whenever a user gesture (pointer tap/scroll/key) is captured.
  void userActivityDetected() {
    if (!_isRunning) return;
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(_timeoutDuration, _handleTimeout);
  }

  void _handleTimeout() {
    // Trigger session lock state
    _ref.read(sessionLockProvider.notifier).state = true;
  }
}

/// Provides the inactivity timeout tracking service.
final sessionTimerServiceProvider = Provider<SessionTimerService>((ref) {
  final service = SessionTimerService(ref);
  ref.onDispose(() => service.stop());
  return service;
});
