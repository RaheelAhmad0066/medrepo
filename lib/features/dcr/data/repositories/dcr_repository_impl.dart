import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/features/dcr/data/datasources/dcr_local_datasource.dart';
import 'package:medrep_pro/features/dcr/data/datasources/dcr_remote_datasource.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_doctor_visit_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_chemist_visit_dto.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_doctor_visit.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_chemist_visit.dart';
import 'package:medrep_pro/features/dcr/domain/repositories/dcr_repository.dart';

class DcrRepositoryImpl implements DcrRepository {
  final DcrRemoteDataSource _remoteDataSource;
  final DcrLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  DcrRepositoryImpl({
    required DcrRemoteDataSource remoteDataSource,
    required DcrLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectivityService = connectivityService;

  @override
  Future<ApiResult<List<Dcr>>> getDcrsByRep(String repId, {bool forceRefresh = false}) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected && forceRefresh) {
        try {
          final remoteDtos = await _remoteDataSource.getDcrsByRep(repId);
          for (final dto in remoteDtos) {
            await _localDataSource.saveDcr(dto);
          }
          return Success(remoteDtos.map((e) => e.toDomain()).toList());
        } catch (_) {
          // Fallback to local
        }
      }

      final localDtos = await _localDataSource.getDcrsByRep(repId);
      return Success(localDtos.map((e) => e.toDomain()).toList());
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<Dcr?>> getTodayDcr(String repId, DateTime date) async {
    try {
      final localDto = await _localDataSource.getDcrByDate(repId, date);
      return Success(localDto?.toDomain());
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> createOrUpdateDcr(Dcr dcr) async {
    try {
      final dto = DcrDto.fromDomain(dcr);
      await _localDataSource.saveDcr(dto);

      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        try {
          await _remoteDataSource.upsertDcr(dto);
        } catch (e) {
          // Queue for sync later
        }
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<DcrDoctorVisit>>> getDoctorVisits(String dcrId) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected) {
        try {
          final remoteVisits = await _remoteDataSource.getDoctorVisits(dcrId);
          for (final visit in remoteVisits) {
            await _localDataSource.saveDoctorVisit(visit);
          }
        } catch (_) {}
      }

      final localVisits = await _localDataSource.getDoctorVisits(dcrId);
      return Success(localVisits.map((e) => e.toDomain()).toList());
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> addDoctorVisit(DcrDoctorVisit visit) async {
    try {
      final dto = DcrDoctorVisitDto.fromDomain(visit);
      await _localDataSource.saveDoctorVisit(dto);

      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        try {
          await _remoteDataSource.upsertDoctorVisits([dto]);
        } catch (e) {
          // Sync later
        }
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> deleteDoctorVisit(String visitId) async {
    try {
      await _localDataSource.deleteDoctorVisit(visitId);
      // Ideally flag for remote deletion in a sync queue
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<DcrChemistVisit>>> getChemistVisits(String dcrId) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected) {
        try {
          final remoteVisits = await _remoteDataSource.getChemistVisits(dcrId);
          for (final visit in remoteVisits) {
            await _localDataSource.saveChemistVisit(visit);
          }
        } catch (_) {}
      }

      final localVisits = await _localDataSource.getChemistVisits(dcrId);
      return Success(localVisits.map((e) => e.toDomain()).toList());
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> addChemistVisit(DcrChemistVisit visit) async {
    try {
      final dto = DcrChemistVisitDto.fromDomain(visit);
      await _localDataSource.saveChemistVisit(dto);

      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        try {
          await _remoteDataSource.upsertChemistVisits([dto]);
        } catch (e) {
          // Sync later
        }
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> deleteChemistVisit(String visitId) async {
    try {
      await _localDataSource.deleteChemistVisit(visitId);
      // Ideally flag for remote deletion in a sync queue
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> syncPendingDcrs() async {
    // Implement standard sync behavior
    return const Success(null);
  }
}
