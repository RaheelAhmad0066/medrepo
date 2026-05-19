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
import 'package:medrep_pro/core/services/biometric_service.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:medrep_pro/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:medrep_pro/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:medrep_pro/features/auth/domain/usecases/verify_otp_usecase.dart';

/// Provides the BiometricService.
final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

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
  return DioClient(
    secureStorage: secureStorage,
    logger: logger,
    clerkTokenProvider: () async {
      try {
        final clerkAuth = ref.read(clerkAuthProvider);
        if (clerkAuth.isSignedIn) {
          final token = await clerkAuth.sessionToken();
          return token.jwt;
        }
      } catch (_) {}
      return null;
    },
  );
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

/// Provides the AuthRepository implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final clerkAuth = ref.watch(clerkAuthProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final biometricService = ref.watch(biometricServiceProvider);
  return AuthRepositoryImpl(
    clerkAuth: clerkAuth,
    secureStorage: secureStorage,
    biometricService: biometricService,
  );
});

/// Provides the SendOtpUseCase.
final sendOtpUseCaseProvider = Provider<SendOtpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SendOtpUseCase(repository);
});

/// Provides the VerifyOtpUseCase.
final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return VerifyOtpUseCase(repository);
});
