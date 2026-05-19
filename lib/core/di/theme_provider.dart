import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/theme/app_theme.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/services/local_storage_service.dart';

final lightThemeProvider = Provider<ThemeData>((ref) => AppTheme.lightTheme);
final darkThemeProvider = Provider<ThemeData>((ref) => AppTheme.darkTheme);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final localStorage = ref.watch(localStorageProvider);
  return ThemeNotifier(localStorage);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final LocalStorageService _localStorage;

  ThemeNotifier(this._localStorage) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedMode = _localStorage.getThemeMode();
    switch (savedMode) {
      case 'light':
        state = ThemeMode.light;
      case 'dark':
        state = ThemeMode.dark;
      default:
        state = ThemeMode.system;
    }
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    state = mode;
    String modeString = 'system';
    if (mode == ThemeMode.light) {
      modeString = 'light';
    } else if (mode == ThemeMode.dark) {
      modeString = 'dark';
    }
    await _localStorage.saveThemeMode(modeString);
  }
}
