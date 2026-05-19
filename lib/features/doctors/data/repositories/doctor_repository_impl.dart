import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/features/doctors/data/datasources/doctor_remote_datasource.dart';
import 'package:medrep_pro/features/doctors/data/datasources/doctor_local_datasource.dart';
import 'package:medrep_pro/features/doctors/data/models/doctor_dto.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource _remoteDataSource;
  final DoctorLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;
  final AppDatabase _db;

  DoctorRepositoryImpl({
    required DoctorRemoteDataSource remoteDataSource,
    required DoctorLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
    required AppDatabase db,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectivityService = connectivityService,
        _db = db;

  @override
  Future<ApiResult<List<Doctor>>> getDoctors({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? tier,
    bool forceRefresh = false,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected && forceRefresh) {
        try {
          final remoteDtos = await _remoteDataSource.getDoctors(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            tier: tier,
          );
          await _localDataSource.saveDoctors(remoteDtos);
          return Success(remoteDtos.map((e) => e.toDomain()).toList());
        } catch (_) {
          // Fallback to cache on remote failure
        }
      }

      final localDtos = await _localDataSource.getDoctors(
        page: page,
        limit: limit,
        searchQuery: searchQuery,
        tier: tier,
      );

      // If local cache is empty and connected, try fetching from remote anyway
      if (localDtos.isEmpty && isConnected) {
        try {
          final remoteDtos = await _remoteDataSource.getDoctors(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            tier: tier,
          );
          await _localDataSource.saveDoctors(remoteDtos);
          return Success(remoteDtos.map((e) => e.toDomain()).toList());
        } catch (e) {
          return FailureResult(ServerFailure(message: e.toString()));
        }
      }

      return Success(localDtos.map((e) => e.toDomain()).toList());
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<Doctor>> addDoctor(Doctor doctor) async {
    final dto = DoctorDto.fromDomain(doctor);
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteDto = await _remoteDataSource.addDoctor(dto);
        await _localDataSource.saveDoctor(remoteDto);
        return Success(remoteDto.toDomain());
      } else {
        // Queue operation offline
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/doctors'),
            method: const Value('POST'),
            payload: Value(jsonEncode(dto.toJson())),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveDoctor(dto);
        return Success(doctor);
      }
    } catch (e) {
      // Fallback: save locally and queue if request fails
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/doctors'),
          method: const Value('POST'),
          payload: Value(jsonEncode(dto.toJson())),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveDoctor(dto);
      return Success(doctor);
    }
  }

  @override
  Future<ApiResult<Doctor>> updateDoctor(Doctor doctor) async {
    final dto = DoctorDto.fromDomain(doctor);
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteDto = await _remoteDataSource.updateDoctor(dto);
        await _localDataSource.saveDoctor(remoteDto);
        return Success(remoteDto.toDomain());
      } else {
        // Queue operation offline
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/doctors'),
            method: const Value('PUT'),
            payload: Value(jsonEncode(dto.toJson())),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveDoctor(dto);
        return Success(doctor);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/doctors'),
          method: const Value('PUT'),
          payload: Value(jsonEncode(dto.toJson())),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveDoctor(dto);
      return Success(doctor);
    }
  }

  @override
  Future<ApiResult<void>> deleteDoctor(String doctorId) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        await _remoteDataSource.deleteDoctor(doctorId);
        await _localDataSource.softDeleteDoctor(doctorId);
        return const Success(null);
      } else {
        // Queue operation offline
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/doctors'),
            method: const Value('DELETE'),
            payload: Value(jsonEncode({'id': doctorId})),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.softDeleteDoctor(doctorId);
        return const Success(null);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/doctors'),
          method: const Value('DELETE'),
          payload: Value(jsonEncode({'id': doctorId})),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.softDeleteDoctor(doctorId);
      return const Success(null);
    }
  }

  @override
  Future<ApiResult<void>> importDoctorsFromExcel(List<Doctor> doctors) async {
    try {
      final dtos = doctors.map((e) => DoctorDto.fromDomain(e)).toList();
      await _localDataSource.saveDoctors(dtos);

      // Enqueue sync item for batch import
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/doctors/import'),
          method: const Value('POST'),
          payload: Value(jsonEncode(dtos.map((e) => e.toJson()).toList())),
          status: const Value('pending'),
        ),
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }
}
