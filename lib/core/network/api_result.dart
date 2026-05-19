import 'package:medrep_pro/core/error/failures.dart';

/// Sealed class that models network and repository responses in Clean Architecture.
sealed class ApiResult<T> {
  const ApiResult();

  /// Executes [onSuccess] or [onFailure] depending on the outcome.
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else if (this is FailureResult<T>) {
      return onFailure((this as FailureResult<T>).failure);
    }
    throw AssertionError('Invalid state: $this');
  }

  /// Maps the success type, leaving failure unchanged.
  ApiResult<R> map<R>(R Function(T data) transform) {
    return when(
      onSuccess: (data) => Success<R>(transform(data)),
      onFailure: (failure) => FailureResult<R>(failure),
    );
  }
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends ApiResult<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
