import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';
import 'package:medrep_pro/core/services/local_storage_service.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/services/sync/sync_engine.dart';
import 'package:medrep_pro/features/auth/domain/repositories/user_repository.dart';
import 'package:medrep_pro/features/auth/data/repositories/user_repository_impl.dart';

/// Provides the Sentry/Logger instance for application diagnostics.
final loggerProvider = Provider<Logger>((ref) {
  return Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );
});

/// Provides SharedPreferences. This must be overridden in main.dart during app startup.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences has not been initialized');
});

/// Provides the custom LocalStorageService wrapper.
final localStorageProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});

/// Provides the standard FlutterSecureStorage client.
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  const secureStorage = FlutterSecureStorage();
  return SecureStorageService(secureStorage);
});

/// Provides the custom ConnectivityService.
final connectivityProvider = Provider<ConnectivityService>((ref) {
  final connectivity = Connectivity();
  return ConnectivityService(connectivity);
});

/// Provides the custom API/Network client.
final dioClientProvider = Provider<DioClient>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  return DioClient(secureStorage: secureStorage, logger: logger);
});

/// Provides the local SQLite Drift database.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Provides the SyncEngine singleton for handling offline sync queues.
final syncEngineProvider = Provider<SyncEngine>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final dioClient = ref.watch(dioClientProvider);
  final connectivity = ref.watch(connectivityProvider);
  final logger = ref.watch(loggerProvider);
  
  final engine = SyncEngine(
    db: db,
    dioClient: dioClient,
    connectivityService: connectivity,
    logger: logger,
  );
  
  // Initialize connectivity listeners
  engine.initialize();
  ref.onDispose(() => engine.dispose());
  
  return engine;
});

/// Provides the UserRepository implementation.
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final db = ref.watch(appDatabaseProvider);
  return UserRepositoryImpl(
    dioClient: dioClient,
    secureStorage: secureStorage,
    db: db,
  );
});
