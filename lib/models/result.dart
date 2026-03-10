sealed class Result<T> {
  const Result();
}

class SuccessResult<T> extends Result<T> {
  const SuccessResult({
    required this.result,
  });

  final T result;
}

class ErrorResult<T> extends Result<T> {
  const ErrorResult({
    required this.error,
  });

  final String error;
}
