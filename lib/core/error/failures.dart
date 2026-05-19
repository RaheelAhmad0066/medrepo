import 'package:equatable/equatable.dart';

/// Base failure class representing mapped errors safe for presentation layer.
sealed class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => '$runtimeType: $message';
}

/// Represents server-side errors and bad API responses.
class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}

/// Represents local database caching or storage failures.
class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
  }) : super(message);
}

/// Represents lack of connection or network timeout failures.
class NetworkFailure extends Failure {
  const NetworkFailure({
    required String message,
  }) : super(message);
}

/// Represents authentication, token expiry, or session failures.
class AuthFailure extends Failure {
  const AuthFailure({
    required String message,
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}

/// Represents synchronization or offline operation queuing failures.
class SyncFailure extends Failure {
  const SyncFailure({
    required String message,
  }) : super(message);
}
