import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/features/tour_plans/data/datasources/tour_plan_remote_datasource.dart';
import 'package:medrep_pro/features/tour_plans/data/datasources/tour_plan_local_datasource.dart';
import 'package:medrep_pro/features/tour_plans/data/models/tour_plan_dto.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/domain/repositories/tour_plan_repository.dart';

class TourPlanRepositoryImpl implements TourPlanRepository {
  final TourPlanRemoteDataSource _remoteDataSource;
  final TourPlanLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;
  final AppDatabase _db;

  TourPlanRepositoryImpl({
    required TourPlanRemoteDataSource remoteDataSource,
    required TourPlanLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
    required AppDatabase db,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectivityService = connectivityService,
        _db = db;

  @override
  Future<ApiResult<List<TourPlan>>> getTourPlans({
    int page = 1,
    int limit = 15,
    String? repId,
    bool forceRefresh = false,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected && forceRefresh) {
        try {
          final remotePlans = await _remoteDataSource.getTourPlans(
            page: page,
            limit: limit,
            repId: repId,
          );
          await _localDataSource.saveTourPlans(remotePlans);
          return Success(remotePlans);
        } catch (_) {
          // Fallback to local cache
        }
      }

      final localPlans = await _localDataSource.getTourPlans(
        page: page,
        limit: limit,
        repId: repId,
      );

      if (localPlans.isEmpty && isConnected) {
        try {
          final remotePlans = await _remoteDataSource.getTourPlans(
            page: page,
            limit: limit,
            repId: repId,
          );
          await _localDataSource.saveTourPlans(remotePlans);
          return Success(remotePlans);
        } catch (e) {
          return FailureResult(ServerFailure(message: e.toString()));
        }
      }

      return Success(localPlans);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<TourPlan>> addTourPlan(TourPlan tourPlan) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remotePlan = await _remoteDataSource.addTourPlan(tourPlan);
        await _localDataSource.saveTourPlan(remotePlan);
        return Success(remotePlan);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/tour-plans'),
            method: const Value('POST'),
            payload: Value(jsonEncode(TourPlanDto.toJson(tourPlan))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveTourPlan(tourPlan);
        return Success(tourPlan);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/tour-plans'),
          method: const Value('POST'),
          payload: Value(jsonEncode(TourPlanDto.toJson(tourPlan))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveTourPlan(tourPlan);
      return Success(tourPlan);
    }
  }

  @override
  Future<ApiResult<TourPlan>> updateTourPlan(TourPlan tourPlan) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remotePlan = await _remoteDataSource.updateTourPlan(tourPlan);
        await _localDataSource.saveTourPlan(remotePlan);
        return Success(remotePlan);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/tour-plans'),
            method: const Value('PUT'),
            payload: Value(jsonEncode(TourPlanDto.toJson(tourPlan))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveTourPlan(tourPlan);
        return Success(tourPlan);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/tour-plans'),
          method: const Value('PUT'),
          payload: Value(jsonEncode(TourPlanDto.toJson(tourPlan))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveTourPlan(tourPlan);
      return Success(tourPlan);
    }
  }

  @override
  Future<ApiResult<void>> deleteTourPlan(String id) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        await _remoteDataSource.deleteTourPlan(id);
        await _localDataSource.softDeleteTourPlan(id);
        return const Success(null);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/tour-plans'),
            method: const Value('DELETE'),
            payload: Value(jsonEncode({'id': id})),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.softDeleteTourPlan(id);
        return const Success(null);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/tour-plans'),
          method: const Value('DELETE'),
          payload: Value(jsonEncode({'id': id})),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.softDeleteTourPlan(id);
      return const Success(null);
    }
  }

  @override
  Future<ApiResult<List<TourPlanStop>>> getTourPlanStops(String tourPlanId) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected) {
        try {
          final remoteStops = await _remoteDataSource.getTourPlanStops(tourPlanId);
          await _localDataSource.saveTourPlanStops(remoteStops);
          return Success(remoteStops);
        } catch (_) {
          // Fallback to local cache
        }
      }

      final localStops = await _localDataSource.getTourPlanStops(tourPlanId);
      return Success(localStops);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> saveTourPlanStops(List<TourPlanStop> stops) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        await _remoteDataSource.saveTourPlanStops(stops);
        await _localDataSource.saveTourPlanStops(stops);
        return const Success(null);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/tour-plans/stops'),
            method: const Value('POST'),
            payload: Value(jsonEncode(stops.map((e) => TourPlanStopDto.toJson(e)).toList())),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveTourPlanStops(stops);
        return const Success(null);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/tour-plans/stops'),
          method: const Value('POST'),
          payload: Value(jsonEncode(stops.map((e) => TourPlanStopDto.toJson(e)).toList())),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveTourPlanStops(stops);
      return const Success(null);
    }
  }

  @override
  Future<ApiResult<TourPlanStop>> checkInStop(TourPlanStop stop) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteStop = await _remoteDataSource.checkInStop(stop);
        await _localDataSource.saveTourPlanStop(remoteStop);
        return Success(remoteStop);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/tour-plans/check-in'),
            method: const Value('POST'),
            payload: Value(jsonEncode(TourPlanStopDto.toJson(stop))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveTourPlanStop(stop);
        return Success(stop);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/tour-plans/check-in'),
          method: const Value('POST'),
          payload: Value(jsonEncode(TourPlanStopDto.toJson(stop))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveTourPlanStop(stop);
      return Success(stop);
    }
  }
}
