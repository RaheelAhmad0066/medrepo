import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'app_database.g.dart';

@DataClassName('SyncQueueItem')
class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get endpoint => text()();
  TextColumn get method => text()(); // e.g., 'POST', 'PUT', 'DELETE'
  TextColumn get payload => text().nullable()(); // JSON payload
  TextColumn get headers => text().nullable()(); // JSON headers (e.g. auth / content type overrides)
  TextColumn get status => text()(); // 'pending', 'syncing', 'failed', 'conflict'
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('CachedApiResponse')
class CachedApiTable extends Table {
  TextColumn get endpointKey => text()(); // Unique cache key (e.g. URI + query parameters)
  TextColumn get responseJson => text()(); // Cached JSON body
  DateTimeColumn get expiresAt => dateTime()(); // Cache expiration timestamp
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {endpointKey};
}

@DriftDatabase(tables: [SyncQueueTable, CachedApiTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Custom DB queries / operations for Sync Queue
  Future<List<SyncQueueItem>> getPendingSyncItems() {
    return (select(syncQueueTable)
          ..where((t) => t.status.equals('pending') | t.status.equals('failed'))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
  }

  Future<int> enqueueSyncItem(SyncQueueTableCompanion companion) {
    return into(syncQueueTable).insert(companion);
  }

  Future<void> updateSyncItemStatus(int id, String status, {String? errorMessage, int? newRetryCount}) {
    return (update(syncQueueTable)..where((t) => t.id.equals(id))).write(
      SyncQueueTableCompanion(
        status: Value(status),
        errorMessage: Value(errorMessage),
        retryCount: newRetryCount != null ? Value(newRetryCount) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteSyncItem(int id) {
    return (delete(syncQueueTable)..where((t) => t.id.equals(id))).go();
  }

  // Custom DB queries / operations for Cached API responses
  Future<CachedApiResponse?> getCachedResponse(String key) {
    return (select(cachedApiTable)..where((t) => t.endpointKey.equals(key)))
        .getSingleOrNull();
  }

  Future<void> insertOrUpdateCache(CachedApiTableCompanion companion) {
    return into(cachedApiTable).insertOnConflictUpdate(companion);
  }

  Future<int> deleteCache(String key) {
    return (delete(cachedApiTable)..where((t) => t.endpointKey.equals(key))).go();
  }

  Future<int> clearExpiredCache() {
    return (delete(cachedApiTable)..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now()))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'medrep_pro.db'));
    
    // Get temporary directory override if specified
    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
