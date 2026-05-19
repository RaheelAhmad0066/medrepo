import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/chemists/data/models/chemist_dto.dart';

class ChemistLocalDataSource {
  final AppDatabase _db;

  ChemistLocalDataSource(this._db);

  Future<List<ChemistDto>> getChemists({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? priorityTag,
  }) async {
    final query = _db.select(_db.chemistsTable)
      ..where((t) => t.isDeleted.equals(false));

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((t) => t.name.like('%$searchQuery%') | t.address.like('%$searchQuery%'));
    }

    if (priorityTag != null && priorityTag.isNotEmpty) {
      query.where((t) => t.priorityTag.equals(priorityTag));
    }

    query.limit(limit, offset: (page - 1) * limit);

    final results = await query.get();
    return results.map((row) => ChemistDto.fromDb(row)).toList();
  }

  Future<void> saveChemists(List<ChemistDto> chemists) async {
    await _db.batch((batch) {
      for (final chem in chemists) {
        batch.insert(
          _db.chemistsTable,
          chem.toCompanion(),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> saveChemist(ChemistDto chemist) async {
    await _db.into(_db.chemistsTable).insertOnConflictUpdate(chemist.toCompanion());
  }

  Future<ChemistDto?> getChemistById(String id) async {
    final query = _db.select(_db.chemistsTable)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row != null) {
      return ChemistDto.fromDb(row);
    }
    return null;
  }

  Future<void> softDeleteChemist(String id) async {
    await (_db.update(_db.chemistsTable)..where((t) => t.id.equals(id))).write(
      const ChemistsTableCompanion(
        isDeleted: Value(true),
        lastModifiedAt: Value.absent(),
      ),
    );
  }
}
