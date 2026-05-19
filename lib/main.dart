import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medrep_pro/config/env/app_env.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/di/theme_provider.dart';
import 'package:medrep_pro/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize App Configuration Environment (Defaulting to Dev flavor)
  AppEnv.init(AppEnvironment.development);

  // Pre-initialize SharedPreferences for Riverpod provider override
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
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

    return MaterialApp.router(
      title: 'MedRep Pro',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
