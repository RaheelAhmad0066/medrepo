import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_doctor_visit_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_chemist_visit_dto.dart';

class DcrLocalDataSource {
  final AppDatabase _db;

  DcrLocalDataSource(this._db);

  // --- DCR Operations ---
  Future<List<DcrDto>> getDcrsByRep(String repId) async {
    final query = _db.select(_db.dcrsTable)
      ..where((t) => t.repId.equals(repId))
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]);
    final results = await query.get();
    return results.map((row) => DcrDto.fromDb(row)).toList();
  }

  Future<DcrDto?> getDcrByDate(String repId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final query = _db.select(_db.dcrsTable)
      ..where((t) =>
          t.repId.equals(repId) &
          t.date.isBiggerOrEqualValue(startOfDay) &
          t.date.isSmallerThanValue(endOfDay));
    final row = await query.getSingleOrNull();
    return row != null ? DcrDto.fromDb(row) : null;
  }

  Future<void> saveDcr(DcrDto dcr) async {
    await _db.into(_db.dcrsTable).insertOnConflictUpdate(dcr.toCompanion());
  }

  // --- Doctor Visits ---
  Future<List<DcrDoctorVisitDto>> getDoctorVisits(String dcrId) async {
    final query = _db.select(_db.dcrDoctorVisitsTable)..where((t) => t.dcrId.equals(dcrId));
    final results = await query.get();
    return results.map((row) => DcrDoctorVisitDto.fromDb(row)).toList();
  }

  Future<void> saveDoctorVisit(DcrDoctorVisitDto visit) async {
    await _db.into(_db.dcrDoctorVisitsTable).insertOnConflictUpdate(visit.toCompanion());
  }

  Future<void> deleteDoctorVisit(String id) async {
    await (_db.delete(_db.dcrDoctorVisitsTable)..where((t) => t.id.equals(id))).go();
  }

  // --- Chemist Visits ---
  Future<List<DcrChemistVisitDto>> getChemistVisits(String dcrId) async {
    final query = _db.select(_db.dcrChemistVisitsTable)..where((t) => t.dcrId.equals(dcrId));
    final results = await query.get();
    return results.map((row) => DcrChemistVisitDto.fromDb(row)).toList();
  }

  Future<void> saveChemistVisit(DcrChemistVisitDto visit) async {
    await _db.into(_db.dcrChemistVisitsTable).insertOnConflictUpdate(visit.toCompanion());
  }

  Future<void> deleteChemistVisit(String id) async {
    await (_db.delete(_db.dcrChemistVisitsTable)..where((t) => t.id.equals(id))).go();
  }
}
