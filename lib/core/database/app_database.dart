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

class DoctorsTable extends Table {
  TextColumn get id => text()(); // UUID primary key generated offline
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get specialty => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get clinicAddress => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get tier => text()(); // 'A', 'B', 'C'
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get lastModifiedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ChemistsTable extends Table {
  TextColumn get id => text()(); // UUID primary key generated offline
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get priorityTag => text()(); // 'High', 'Medium', 'Low'
  RealColumn get outstandingBalance => real().withDefault(const Constant(0.0))();
  RealColumn get creditLimit => real().withDefault(const Constant(0.0))();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get lastModifiedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsTable extends Table {
  TextColumn get id => text()(); // UUID primary key generated offline
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get sku => text()();
  RealColumn get price => real()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get pdfVisualAidUrl => text().nullable()();
  BoolColumn get isDiscontinued => boolean().withDefault(const Constant(false))();
  BoolColumn get isSampleEligible => boolean().withDefault(const Constant(true))();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get lastModifiedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class PriceHistoryTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get productId => text()();
  RealColumn get price => real()();
  DateTimeColumn get effectiveFrom => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TourPlansTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get tenantId => text()();
  TextColumn get repId => text()();
  DateTimeColumn get plannedDate => dateTime()();
  TextColumn get routeOptimizationOrder => text()(); // JSON list of optimized stops
  TextColumn get status => text()(); // 'Draft', 'Pending Approval', 'Approved', 'Rejected'
  TextColumn get managerComment => text().nullable()();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get lastModifiedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class TourPlanStopsTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get tourPlanId => text()();
  TextColumn get targetType => text()(); // 'Doctor', 'Chemist'
  TextColumn get targetId => text()();
  IntColumn get sequenceOrder => integer()();
  BoolColumn get checkedIn => boolean().withDefault(const Constant(false))();
  DateTimeColumn get checkInTime => dateTime().nullable()();
  RealColumn get checkInLatitude => real().nullable()();
  RealColumn get checkInLongitude => real().nullable()();
  TextColumn get deviationReason => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DcrsTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get repId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()(); // 'draft', 'submitted', 'acknowledged'
  TextColumn get managerComment => text().nullable()();
  TextColumn get voiceMemoUrl => text().nullable()();
  DateTimeColumn get submittedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class DcrDoctorVisitsTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get dcrId => text()();
  TextColumn get doctorId => text()();
  TextColumn get session => text()(); // 'morning', 'evening'
  DateTimeColumn get visitTime => dateTime().nullable()();
  TextColumn get callOutcome => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get gpsLat => real().nullable()();
  RealColumn get gpsLng => real().nullable()();
  TextColumn get photoUrl => text().nullable()();
  BoolColumn get isPlanned => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class DcrChemistVisitsTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get dcrId => text()();
  TextColumn get chemistId => text()();
  TextColumn get session => text()(); // 'morning', 'evening'
  DateTimeColumn get visitTime => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get gpsLat => real().nullable()();
  RealColumn get gpsLng => real().nullable()();
  TextColumn get photoUrl => text().nullable()();
  BoolColumn get isPlanned => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class DcrVisitProductsTable extends Table {
  TextColumn get id => text()(); // UUID primary key
  TextColumn get visitId => text()(); // DcrDoctorVisit ID
  TextColumn get productId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  SyncQueueTable,
  CachedApiTable,
  DoctorsTable,
  ChemistsTable,
  ProductsTable,
  PriceHistoryTable,
  TourPlansTable,
  TourPlanStopsTable,
  DcrsTable,
  DcrDoctorVisitsTable,
  DcrChemistVisitsTable,
  DcrVisitProductsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(doctorsTable);
            await m.createTable(chemistsTable);
          }
          if (from < 3) {
            await m.createTable(productsTable);
            await m.createTable(priceHistoryTable);
            await m.createTable(tourPlansTable);
            await m.createTable(tourPlanStopsTable);
          }
          if (from < 4) {
            await m.createTable(dcrsTable);
            await m.createTable(dcrDoctorVisitsTable);
            await m.createTable(dcrChemistVisitsTable);
            await m.createTable(dcrVisitProductsTable);
          }
        },
      );

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
