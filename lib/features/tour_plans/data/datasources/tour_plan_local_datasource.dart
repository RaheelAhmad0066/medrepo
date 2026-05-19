import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/data/models/tour_plan_dto.dart';

class TourPlanLocalDataSource {
  final AppDatabase _db;

  TourPlanLocalDataSource(this._db);

  Future<List<TourPlan>> getTourPlans({
    int page = 1,
    int limit = 15,
    String? repId,
  }) async {
    final query = _db.select(_db.tourPlansTable)
      ..where((t) => t.isDeleted.equals(false));

    if (repId != null && repId.isNotEmpty) {
      query.where((t) => t.repId.equals(repId));
    }

    query.orderBy([(t) => OrderingTerm(expression: t.plannedDate, mode: OrderingMode.desc)]);
    query.limit(limit, offset: (page - 1) * limit);

    final results = await query.get();
    return results.map((row) => TourPlanDto.fromDb(row)).toList();
  }

  Future<void> saveTourPlans(List<TourPlan> plans) async {
    await _db.batch((batch) {
      for (final plan in plans) {
        batch.insert(
          _db.tourPlansTable,
          TourPlanDto.toDbCompanion(plan),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> saveTourPlan(TourPlan plan) async {
    await _db.into(_db.tourPlansTable).insertOnConflictUpdate(TourPlanDto.toDbCompanion(plan));
  }

  Future<void> softDeleteTourPlan(String id) async {
    await (_db.update(_db.tourPlansTable)..where((t) => t.id.equals(id))).write(
      const TourPlansTableCompanion(
        isDeleted: Value(true),
        lastModifiedAt: Value.absent(),
      ),
    );
  }

  Future<List<TourPlanStop>> getTourPlanStops(String tourPlanId) async {
    final query = _db.select(_db.tourPlanStopsTable)
      ..where((t) => t.tourPlanId.equals(tourPlanId))
      ..orderBy([(t) => OrderingTerm(expression: t.sequenceOrder, mode: OrderingMode.asc)]);
    final results = await query.get();
    return results.map((row) => TourPlanStopDto.fromDb(row)).toList();
  }

  Future<void> saveTourPlanStops(List<TourPlanStop> stops) async {
    await _db.batch((batch) {
      for (final stop in stops) {
        batch.insert(
          _db.tourPlanStopsTable,
          TourPlanStopDto.toDbCompanion(stop),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> saveTourPlanStop(TourPlanStop stop) async {
    await _db.into(_db.tourPlanStopsTable).insertOnConflictUpdate(TourPlanStopDto.toDbCompanion(stop));
  }
}
