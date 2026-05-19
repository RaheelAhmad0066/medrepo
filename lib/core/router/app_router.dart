import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/core/di/auth_provider.dart';

// GoRouter provider that listens to authentication state changes
final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    // Listen to changes in the notifier to trigger redirects
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggingIn = state.matchedLocation == '/login';

      return authState.when(
        data: (user) {
          if (user == null) {
            // User is not logged in. If they are not on login page, send to login.
            return isLoggingIn ? null : '/login';
          }

          // User is logged in. If they are on login page, send to dashboard.
          if (isLoggingIn) return '/';

          // Stay where they are
          return null;
        },
        error: (_, __) => '/login',
        loading: () => null, // Let initial loading screen handle itself
      );
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Screen (Foundation Boilerplate)')),
        ),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Dashboard Screen (Foundation Boilerplate)')),
        ),
      ),
      GoRoute(
        path: '/sync-status',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Sync Queue Status Screen (Foundation Boilerplate)')),
        ),
      ),
    ],
  );
});
