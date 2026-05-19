import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  ConnectivityService(this._connectivity) {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Stream<bool> get onConnectionChanged => _controller.stream;

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _checkResults(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _controller.add(_checkResults(results));
  }

  bool _checkResults(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;
    // If any connection type is not 'none', we are connected
    return results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _controller.close();
  }
}
