import 'package:drift/drift.dart';

@DataClassName('SyncQueueEntry')
class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // E.g., 'dcr_doctor_visits', 'orders', 'expenses'
  TextColumn get entityType => text()();
  
  // JSON payload of the request
  TextColumn get payloadJson => text()();
  
  // INSERT, UPDATE, DELETE
  TextColumn get operation => text()();
  
  // Status: 'pending', 'syncing', 'failed'
  TextColumn get status => text().withDefault(const Constant('pending'))();
  
  // Timestamp when the action was performed offline
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  // Optional error message if sync failed
  TextColumn get errorMessage => text().nullable()();
  
  // Number of retry attempts
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
}
