import 'package:drift/drift.dart';

@DataClassName('TerritoryCache')
class TerritoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get region => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProfileCache')
class ProfilesTable extends Table {
  TextColumn get id => text()();
  TextColumn get clerkUserId => text()();
  TextColumn get fullName => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text().nullable()();
  TextColumn get territoryId => text().nullable()();
  TextColumn get managerId => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DoctorCache')
class DoctorsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get clinicName => text().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get tier => text().nullable()(); // A/B/C
  TextColumn get territoryId => text().nullable()();
  RealColumn get lat => real().nullable()();
  RealColumn get lng => real().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ChemistCache')
class ChemistsTable extends Table {
  TextColumn get id => text()();
  TextColumn get shopName => text()();
  TextColumn get ownerName => text().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get priority => text().nullable()(); // high/regular/occasional
  TextColumn get territoryId => text().nullable()();
  RealColumn get lat => real().nullable()();
  RealColumn get lng => real().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProductCache')
class ProductsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get formulation => text().nullable()();
  TextColumn get category => text().nullable()();
  RealColumn get netPrice => real()();
  BoolColumn get isSampleEligible => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}
