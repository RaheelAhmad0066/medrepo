/// Global application constants for MedRep Pro.
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'MedRep Pro';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache / Sync
  static const int cacheExpiryHours = 24;
  static const int maxSyncRetries = 3;
  static const int syncBatchSize = 50;
  static const Duration syncDebounce = Duration(seconds: 3);

  // Network
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Local DB
  static const String localDbName = 'medrep_pro.db';
  static const int localDbVersion = 1;

  // Secure Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
  static const String keyTenantId = 'tenant_id';
  static const String keyBiometricEnabled = 'biometric_enabled';

  // SharedPreferences Keys
  static const String prefThemeMode = 'theme_mode';
  static const String prefLanguage = 'language';
  static const String prefLastSyncAt = 'last_sync_at';
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefFcmToken = 'fcm_token';

  // Roles
  static const String roleAdmin = 'admin';
  static const String roleManager = 'manager';
  static const String roleSalesRep = 'sales_rep';
  static const String roleSupervisor = 'supervisor';
  static const String roleViewer = 'viewer';

  // Visit Status
  static const String visitStatusPlanned = 'planned';
  static const String visitStatusCompleted = 'completed';
  static const String visitStatusCancelled = 'cancelled';
  static const String visitStatusMissed = 'missed';

  // Order Status
  static const String orderStatusDraft = 'draft';
  static const String orderStatusPending = 'pending';
  static const String orderStatusApproved = 'approved';
  static const String orderStatusRejected = 'rejected';
  static const String orderStatusDelivered = 'delivered';

  // Sync Status
  static const String syncStatusPending = 'pending';
  static const String syncStatusSyncing = 'syncing';
  static const String syncStatusSynced = 'synced';
  static const String syncStatusFailed = 'failed';
  static const String syncStatusConflict = 'conflict';

  // AI
  static const int aiMaxTokens = 2048;
  static const String aiModel = 'gpt-4o-mini';
}
