import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthNotifier(secureStorage)..checkSession();
});

class AuthNotifier extends ChangeNotifier {
  final SecureStorageService _secureStorage;

  AsyncValue<User?> _state = const AsyncValue.loading();
  AsyncValue<User?> get state => _state;

  AuthNotifier(this._secureStorage);

  // Helper to allow GoRouter refreshListenable checks
  R when<R>({
    required R Function(User? user) data,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return _state.when(data: data, error: error, loading: loading);
  }

  Future<void> checkSession() async {
    try {
      final token = await _secureStorage.getAccessToken();
      if (token == null) {
        _state = const AsyncValue.data(null);
      } else {
        // Retrieve profile details from secure storage
        final userId = await _secureStorage.getUserId() ?? 'unknown';
        final role = await _secureStorage.getUserRole() ?? 'sales_rep';
        final tenantId = await _secureStorage.getTenantId() ?? 'default';

        _state = AsyncValue.data(User(
          id: userId,
          email: 'user@medrep-pro.com',
          name: 'Pharma Representative',
          role: role,
          tenantId: tenantId,
        ));
      }
    } catch (e, stack) {
      _state = AsyncValue.error(e, stack);
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _state = const AsyncValue.loading();
    notifyListeners();

    try {
      // Mock API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock save to storage
      await _secureStorage.saveAccessToken('mock_access_token');
      await _secureStorage.saveRefreshToken('mock_refresh_token');
      await _secureStorage.saveUserId('rep_123');
      await _secureStorage.saveUserRole('sales_rep');
      await _secureStorage.saveTenantId('pharma_corp_001');

      _state = const AsyncValue.data(User(
        id: 'rep_123',
        email: 'rep@pharmaco.com',
        name: 'John Doe',
        role: 'sales_rep',
        tenantId: 'pharma_corp_001',
      ));
    } catch (e, stack) {
      _state = AsyncValue.error(e, stack);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _state = const AsyncValue.loading();
    notifyListeners();

    await _secureStorage.clearAll();
    _state = const AsyncValue.data(null);
    notifyListeners();
  }
}
