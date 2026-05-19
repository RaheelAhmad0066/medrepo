import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:medrep_pro/config/env/app_env.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/core/di/theme_provider.dart';
import 'package:medrep_pro/core/router/app_router.dart';
import 'package:medrep_pro/core/services/session_timer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize App Configuration Environment (Defaulting to Dev flavor)
  AppEnv.init(AppEnvironment.development);

  // Pre-initialize SharedPreferences for Riverpod provider override
  final sharedPrefs = await SharedPreferences.getInstance();

  // Pre-initialize Clerk Auth instance
  final auth = clerk.Auth(
    config: clerk.AuthConfig(
      publishableKey: AppEnv.clerkPublishableKey,
      persistor: clerk.DefaultPersistor(
        getCacheDirectory: getApplicationDocumentsDirectory,
      ),
    ),
  );
  await auth.initialize();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        clerkAuthProvider.overrideWithValue(auth),
      ],
      child: const MedRepProApp(),
    ),
  );
}

class MedRepProApp extends ConsumerWidget {
  const MedRepProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);

    // Capture global user activity to reset session inactivity timer
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        ref.read(sessionTimerServiceProvider).userActivityDetected();
      },
      onPointerMove: (_) {
        ref.read(sessionTimerServiceProvider).userActivityDetected();
      },
      child: MaterialApp.router(
        title: 'MedRep Pro',
        debugShowCheckedModeBanner: false,
        theme: ref.watch(lightThemeProvider),
        darkTheme: ref.watch(darkThemeProvider),
        themeMode: themeMode,
        routerConfig: router,
      ),
    );
  }
}
