import 'package:shared_preferences/shared_preferences.dart';
import 'package:medrep_pro/core/constants/app_constants.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  /// Saves the chosen app theme mode (e.g. system, light, dark).
  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(AppConstants.prefThemeMode, themeMode);
  }

  /// Retrieves the persisted app theme mode. Defaults to 'system'.
  String getThemeMode() {
    return _prefs.getString(AppConstants.prefThemeMode) ?? 'system';
  }

  /// Persists the last successful date/time of offline data synchronization.
  Future<void> saveLastSyncAt(int timestamp) async {
    await _prefs.setInt(AppConstants.prefLastSyncAt, timestamp);
  }

  /// Gets the last successful synchronization date/time.
  int? getLastSyncAt() {
    return _prefs.getInt(AppConstants.prefLastSyncAt);
  }

  /// Sets whether the user has completed onboarding steps.
  Future<void> saveOnboardingDone(bool isDone) async {
    await _prefs.setBool(AppConstants.prefOnboardingDone, isDone);
  }

  /// Checks if onboarding is complete.
  bool getOnboardingDone() {
    return _prefs.getBool(AppConstants.prefOnboardingDone) ?? false;
  }

  /// Persists the current active user FCM token for notifications.
  Future<void> saveFcmToken(String token) async {
    await _prefs.setString(AppConstants.prefFcmToken, token);
  }

  /// Gets the saved FCM token.
  String? getFcmToken() {
    return _prefs.getString(AppConstants.prefFcmToken);
  }

  /// Utility to clear generic preferences.
  Future<void> clearSettings() async {
    await _prefs.remove(AppConstants.prefThemeMode);
    await _prefs.remove(AppConstants.prefLastSyncAt);
    await _prefs.remove(AppConstants.prefOnboardingDone);
  }
}
