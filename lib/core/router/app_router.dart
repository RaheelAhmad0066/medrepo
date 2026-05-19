import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state_notifier.dart';
import 'package:medrep_pro/features/auth/presentation/views/login_view.dart';

/// Inactivity lock view displayed when the session times out.
class LockScreenView extends ConsumerWidget {
  const LockScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Session Locked',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'For your security, your session has timed out due to inactivity.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 40),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      ref
                          .read(authStateProvider.notifier)
                          .unlockSessionWithBiometrics();
                    },
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Unlock with Biometrics'),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(authStateProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Log out & Switch User'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  // Create a ValueNotifier to trigger GoRouter refreshes on AuthState changes
  final listenable = ValueNotifier<AuthState>(ref.watch(authStateProvider));
  ref.listen<AuthState>(authStateProvider, (previous, next) {
    listenable.value = next;
  });

  return GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final location = state.matchedLocation;

      final isLoggingIn = location == '/login';
      final isLocked = location == '/lockscreen';

      if (authState is AuthInitial ||
          authState is AuthError ||
          authState is AuthLoading) {
        if (isLoggingIn) return null;
        return '/login';
      }

      if (authState is AuthOtpSent) {
        if (isLoggingIn) return null;
        return '/login';
      }

      if (authState is AuthSessionLocked) {
        if (isLocked) return null;
        return '/lockscreen';
      }

      if (authState is AuthAuthenticated) {
        // Redirection out of entry screens
        if (isLoggingIn || isLocked) return '/';

        // Role guards
        final user = authState.user;
        if (location.startsWith('/admin') && user.role != 'admin') {
          return '/'; // Redirect non-admins to home
        }
        if (location.startsWith('/manager') &&
            user.role != 'admin' &&
            user.role != 'manager') {
          return '/'; // Redirect reps to home
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/lockscreen',
        builder: (context, state) => const LockScreenView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Dashboard Screen')),
        ),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Admin Console')),
        ),
      ),
      GoRoute(
        path: '/manager',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Manager Dashboard')),
        ),
      ),
      GoRoute(
        path: '/sync-status',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Sync Queue Status Screen')),
        ),
      ),
    ],
  );
});
