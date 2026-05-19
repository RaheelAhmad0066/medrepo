/// Environment configuration for MedRep Pro.
/// Supports dev, staging, and production flavors.
enum AppEnvironment { development, staging, production }

class AppEnv {
  AppEnv._();

  static AppEnvironment _env = AppEnvironment.development;
  static AppEnvironment get current => _env;

  static late String supabaseUrl;
  static late String supabaseAnonKey;
  static late String apiBaseUrl;
  static late String sentryDsn;
  static late bool enableAiAssistant;
  static late bool enableAnalytics;
  static late int syncIntervalMinutes;

  static void init(AppEnvironment env) {
    _env = env;
    switch (env) {
      case AppEnvironment.development:
        _initDev();
      case AppEnvironment.staging:
        _initStaging();
      case AppEnvironment.production:
        _initProduction();
    }
  }

  static void _initDev() {
    supabaseUrl = const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://your-dev-project.supabase.co',
    );
    supabaseAnonKey = const String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'your-dev-anon-key',
    );
    apiBaseUrl = 'https://your-dev-project.supabase.co/functions/v1';
    sentryDsn = '';
    enableAiAssistant = true;
    enableAnalytics = false;
    syncIntervalMinutes = 5;
  }

  static void _initStaging() {
    supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
    supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');
    apiBaseUrl = 'https://your-staging-project.supabase.co/functions/v1';
    sentryDsn = const String.fromEnvironment('SENTRY_DSN');
    enableAiAssistant = true;
    enableAnalytics = true;
    syncIntervalMinutes = 10;
  }

  static void _initProduction() {
    supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
    supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');
    apiBaseUrl = 'https://your-prod-project.supabase.co/functions/v1';
    sentryDsn = const String.fromEnvironment('SENTRY_DSN');
    enableAiAssistant = true;
    enableAnalytics = true;
    syncIntervalMinutes = 15;
  }

  static bool get isDev => _env == AppEnvironment.development;
  static bool get isStaging => _env == AppEnvironment.staging;
  static bool get isProd => _env == AppEnvironment.production;
}
