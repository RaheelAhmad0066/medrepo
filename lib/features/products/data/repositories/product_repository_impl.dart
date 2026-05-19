import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/core/error/failures.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';
import 'package:medrep_pro/features/products/data/datasources/product_remote_datasource.dart';
import 'package:medrep_pro/features/products/data/datasources/product_local_datasource.dart';
import 'package:medrep_pro/features/products/data/models/product_dto.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;
  final AppDatabase _db;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required ProductLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
    required AppDatabase db,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectivityService = connectivityService,
        _db = db;

  @override
  Future<ApiResult<List<Product>>> getProducts({
    int page = 1,
    int limit = 15,
    String? searchQuery,
    String? category,
    bool? isDiscontinued,
    bool forceRefresh = false,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected && forceRefresh) {
        try {
          final remoteProducts = await _remoteDataSource.getProducts(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            category: category,
            isDiscontinued: isDiscontinued,
          );
          await _localDataSource.saveProducts(remoteProducts);
          return Success(remoteProducts);
        } catch (_) {
          // Fallback to local cache
        }
      }

      final localProducts = await _localDataSource.getProducts(
        page: page,
        limit: limit,
        searchQuery: searchQuery,
        category: category,
        isDiscontinued: isDiscontinued,
      );

      if (localProducts.isEmpty && isConnected) {
        try {
          final remoteProducts = await _remoteDataSource.getProducts(
            page: page,
            limit: limit,
            searchQuery: searchQuery,
            category: category,
            isDiscontinued: isDiscontinued,
          );
          await _localDataSource.saveProducts(remoteProducts);
          return Success(remoteProducts);
        } catch (e) {
          return FailureResult(ServerFailure(message: e.toString()));
        }
      }

      return Success(localProducts);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<Product>> addProduct(Product product) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteProduct = await _remoteDataSource.addProduct(product);
        await _localDataSource.saveProduct(remoteProduct);
        return Success(remoteProduct);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/products'),
            method: const Value('POST'),
            payload: Value(jsonEncode(ProductDto.toJson(product))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveProduct(product);
        return Success(product);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/products'),
          method: const Value('POST'),
          payload: Value(jsonEncode(ProductDto.toJson(product))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveProduct(product);
      return Success(product);
    }
  }

  @override
  Future<ApiResult<Product>> updateProduct(Product product) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteProduct = await _remoteDataSource.updateProduct(product);
        await _localDataSource.saveProduct(remoteProduct);
        return Success(remoteProduct);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/products'),
            method: const Value('PUT'),
            payload: Value(jsonEncode(ProductDto.toJson(product))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.saveProduct(product);
        return Success(product);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/products'),
          method: const Value('PUT'),
          payload: Value(jsonEncode(ProductDto.toJson(product))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.saveProduct(product);
      return Success(product);
    }
  }

  @override
  Future<ApiResult<void>> deleteProduct(String id) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        await _remoteDataSource.deleteProduct(id);
        await _localDataSource.softDeleteProduct(id);
        return const Success(null);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/products'),
            method: const Value('DELETE'),
            payload: Value(jsonEncode({'id': id})),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.softDeleteProduct(id);
        return const Success(null);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/products'),
          method: const Value('DELETE'),
          payload: Value(jsonEncode({'id': id})),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.softDeleteProduct(id);
      return const Success(null);
    }
  }

  @override
  Future<ApiResult<List<PriceHistoryEntry>>> getPriceHistory(String productId) async {
    try {
      final isConnected = await _connectivityService.isConnected;

      if (isConnected) {
        try {
          final remoteHistory = await _remoteDataSource.getPriceHistory(productId);
          await _localDataSource.savePriceHistoryEntries(remoteHistory);
          return Success(remoteHistory);
        } catch (_) {
          // Fallback to local cache
        }
      }

      final localHistory = await _localDataSource.getPriceHistory(productId);
      return Success(localHistory);
    } catch (e) {
      return FailureResult(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<PriceHistoryEntry>> addPriceHistoryEntry(PriceHistoryEntry entry) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        final remoteEntry = await _remoteDataSource.addPriceHistoryEntry(entry);
        await _localDataSource.savePriceHistoryEntry(remoteEntry);
        return Success(remoteEntry);
      } else {
        await _db.enqueueSyncItem(
          SyncQueueTableCompanion(
            endpoint: const Value('/products/price-history'),
            method: const Value('POST'),
            payload: Value(jsonEncode(PriceHistoryDto.toJson(entry))),
            status: const Value('pending'),
          ),
        );
        await _localDataSource.savePriceHistoryEntry(entry);
        return Success(entry);
      }
    } catch (e) {
      await _db.enqueueSyncItem(
        SyncQueueTableCompanion(
          endpoint: const Value('/products/price-history'),
          method: const Value('POST'),
          payload: Value(jsonEncode(PriceHistoryDto.toJson(entry))),
          status: const Value('pending'),
        ),
      );
      await _localDataSource.savePriceHistoryEntry(entry);
      return Success(entry);
    }
  }
}
