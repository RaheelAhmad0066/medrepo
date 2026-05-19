import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/doctors/data/models/doctor_dto.dart';

class DoctorLocalDataSource {
  final AppDatabase _db;

  DoctorLocalDataSource(this._db);

  Future<List<DoctorDto>> getDoctors({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? tier,
  }) async {
    final query = _db.select(_db.doctorsTable)
      ..where((t) => t.isDeleted.equals(false));

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((t) => t.name.like('%$searchQuery%') | t.specialty.like('%$searchQuery%'));
    }

    if (tier != null && tier.isNotEmpty) {
      query.where((t) => t.tier.equals(tier));
    }

    query.limit(limit, offset: (page - 1) * limit);

    final results = await query.get();
    return results.map((row) => DoctorDto.fromDb(row)).toList();
  }

  Future<void> saveDoctors(List<DoctorDto> doctors) async {
    await _db.batch((batch) {
      for (final doc in doctors) {
        batch.insert(
          _db.doctorsTable,
          doc.toCompanion(),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> saveDoctor(DoctorDto doctor) async {
    await _db.into(_db.doctorsTable).insertOnConflictUpdate(doctor.toCompanion());
  }

  Future<DoctorDto?> getDoctorById(String id) async {
    final query = _db.select(_db.doctorsTable)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row != null) {
      return DoctorDto.fromDb(row);
    }
    return null;
  }

  Future<void> softDeleteDoctor(String id) async {
    await (_db.update(_db.doctorsTable)..where((t) => t.id.equals(id))).write(
      const DoctorsTableCompanion(
        isDeleted: Value(true),
        lastModifiedAt: Value.absent(),
      ),
    );
  }
}
