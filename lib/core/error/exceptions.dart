/// Base exception class for all enterprise exceptions.
sealed class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Thrown when a server or API request fails.
class ServerException extends AppException {
  const ServerException({
    required String message,
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}

/// Thrown when local database or caching operations fail.
class CacheException extends AppException {
  const CacheException({
    required String message,
  }) : super(message);
}

/// Thrown when there is no internet connection or network request times out.
class NetworkException extends AppException {
  const NetworkException({
    required String message,
  }) : super(message);
}

/// Thrown when authentication or token operations fail.
class AuthException extends AppException {
  const AuthException({
    required String message,
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}

/// Thrown when background data synchronization fails.
class SyncException extends AppException {
  const SyncException({
    required String message,
  }) : super(message);
}
