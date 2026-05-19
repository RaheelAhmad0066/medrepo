import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:medrep_pro/core/constants/app_constants.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/core/services/connectivity_service.dart';

class SyncEngine {
  final AppDatabase _db;
  final DioClient _dioClient;
  final ConnectivityService _connectivityService;
  final Logger _logger;

  StreamSubscription<bool>? _connectivitySubscription;
  bool _isSyncing = false;

  SyncEngine({
    required AppDatabase db,
    required DioClient dioClient,
    required ConnectivityService connectivityService,
    required Logger logger,
  })  : _db = db,
        _dioClient = dioClient,
        _connectivityService = connectivityService,
        _logger = logger;

  /// Starts listening to connectivity status shifts to auto-trigger syncing.
  void initialize() {
    _connectivitySubscription = _connectivityService.onConnectionChanged.listen((isConnected) {
      if (isConnected) {
        _logger.i('Connection restored, triggering sync...');
        triggerSync();
      }
    });
  }

  /// Cancels background network connectivity monitoring.
  void dispose() {
    _connectivitySubscription?.cancel();
  }

  /// Iterates through and processes queued api actions.
  Future<void> triggerSync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final isConnected = await _connectivityService.isConnected;
      if (!isConnected) {
        _logger.w('Sync triggered but device is currently offline.');
        _isSyncing = false;
        return;
      }

      final pendingItems = await _db.getPendingSyncItems();
      if (pendingItems.isEmpty) {
        _logger.d('No pending operations in sync queue.');
        _isSyncing = false;
        return;
      }

      _logger.i('SyncEngine: Processing ${pendingItems.length} queued operations.');

      for (final item in pendingItems) {
        final success = await _syncItem(item);
        if (!success) {
          // If a request fails, stop batch sync process to prevent sequence breaks.
          _logger.w('Sync aborted due to operation failure at queue item ID: ${item.id}');
          break;
        }
      }
    } catch (e) {
      _logger.e('Unexpected error during synchronization process: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _syncItem(SyncQueueItem item) async {
    // Mark item state as 'syncing'
    await _db.updateSyncItemStatus(item.id, AppConstants.syncStatusSyncing);

    try {
      final Map<String, dynamic>? data = item.payload != null 
          ? jsonDecode(item.payload!) as Map<String, dynamic>
          : null;

      // Executing request depending on HTTP verb
      switch (item.method.toUpperCase()) {
        case 'POST':
          await _dioClient.post(item.endpoint, data: data);
        case 'PUT':
          await _dioClient.put(item.endpoint, data: data);
        case 'DELETE':
          await _dioClient.delete(item.endpoint, data: data);
        default:
          throw UnsupportedError('HTTP method ${item.method} is not supported by SyncEngine.');
      }

      // Successfully synced, remove item from SQLite queue
      await _db.deleteSyncItem(item.id);
      _logger.i('Queue item ID: ${item.id} (${item.method} ${item.endpoint}) processed successfully.');
      return true;
    } catch (e) {
      _logger.e('Failed to synchronize queue item ID ${item.id}: $e');

      // If retry threshold exceeded, label queue item status as failed or conflicting
      final nextRetryCount = item.retryCount + 1;
      if (nextRetryCount >= AppConstants.maxSyncRetries) {
        _logger.w('Queue item ID ${item.id} exceeded maximum retries. Setting status to failed.');
        await _db.updateSyncItemStatus(
          item.id,
          AppConstants.syncStatusFailed,
          errorMessage: e.toString(),
          newRetryCount: nextRetryCount,
        );
      } else {
        // Otherwise, reset to 'pending' to retry during subsequent iterations
        await _db.updateSyncItemStatus(
          item.id,
          AppConstants.syncStatusPending,
          errorMessage: e.toString(),
          newRetryCount: nextRetryCount,
        );
      }
      return false;
    }
  }
}
