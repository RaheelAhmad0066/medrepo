import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/features/chemists/data/datasources/chemist_remote_datasource.dart';
import 'package:medrep_pro/features/chemists/data/datasources/chemist_local_datasource.dart';
import 'package:medrep_pro/features/chemists/data/models/chemist_dto.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/chemists/domain/repositories/chemist_repository.dart';

class ChemistRepositoryImpl implements ChemistRepository {
  final ChemistRemoteDataSource _remoteDataSource;
  final ChemistLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;
  final AppDatabase _db;

  ChemistRepositoryImpl({
    required ChemistRemoteDataSource remoteDataSource,
    required ChemistLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
    required AppDatabase db,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectivityService = connectivityService,
        _db = db;

  @override
  Future<ApiResult<List<Chemist>>> getChemists({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? priorityTag,
    bool forceRefresh = false,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected && forceRefresh) {
        try {
          final remoteDtos = await _remoteDataSource.getChemists(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            priorityTag: priorityTag,
          );
          await _localDataSource.saveChemists(remoteDtos);
          return Success(remoteDtos.map((e) => e.toDomain()).toList());
        } catch (_) {
          // Fallback to cache on remote failure
        }
      }

      final localDtos = await _localDataSource.getChemists(
        page: page,
        limit: limit,
        searchQuery: searchQuery,
        priorityTag: priorityTag,
      );

      // If local cache is empty and connected, try fetching from remote anyway
      if (localDtos.isEmpty && isConnected) {
        try {
          final remoteDtos = await _remoteDataSource.getChemists(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            priorityTag: priorityTag,
          );
          await _localDataSource.saveChemists(remoteDtos);
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
  Future<ApiResult<Chemist>> addChemist(Chemist chemist) async {
    final dto = ChemistDto.fromDomain(chemist);
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteDto = await _remoteDataSource.addChemist(dto);
        await _localDataSource.saveChemist(remoteDto);
        return Success(remoteDto.toDomain());
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/chemists'),
            method: const Value('POST'),
            payload: Value(jsonEncode(dto.toJson())),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveChemist(dto);
        return Success(chemist);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/chemists'),
          method: const Value('POST'),
          payload: Value(jsonEncode(dto.toJson())),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveChemist(dto);
      return Success(chemist);
    }
  }

  @override
  Future<ApiResult<Chemist>> updateChemist(Chemist chemist) async {
    final dto = ChemistDto.fromDomain(chemist);
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteDto = await _remoteDataSource.updateChemist(dto);
        await _localDataSource.saveChemist(remoteDto);
        return Success(remoteDto.toDomain());
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/chemists'),
            method: const Value('PUT'),
            payload: Value(jsonEncode(dto.toJson())),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveChemist(dto);
        return Success(chemist);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/chemists'),
          method: const Value('PUT'),
          payload: Value(jsonEncode(dto.toJson())),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveChemist(dto);
      return Success(chemist);
    }
  }

  @override
  Future<ApiResult<void>> deleteChemist(String chemistId) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        await _remoteDataSource.deleteChemist(chemistId);
        await _localDataSource.softDeleteChemist(chemistId);
        return const Success(null);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/chemists'),
            method: const Value('DELETE'),
            payload: Value(jsonEncode({'id': chemistId})),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.softDeleteChemist(chemistId);
        return const Success(null);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/chemists'),
          method: const Value('DELETE'),
          payload: Value(jsonEncode({'id': chemistId})),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.softDeleteChemist(chemistId);
      return const Success(null);
    }
  }
}
