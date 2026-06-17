sealed class UiStatus {
  const UiStatus();
  const factory UiStatus.idle() = UiIdle;
  const factory UiStatus.loading() = UiLoading;
  const factory UiStatus.success(dynamic data) = UiSuccess;
  const factory UiStatus.error(String message) = UiError;

  TResult maybeWhen<TResult>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(dynamic data)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final status = this;
    if (status is UiIdle && idle != null) return idle();
    if (status is UiLoading && loading != null) return loading();
    if (status is UiSuccess && success != null) return success(status.data);
    if (status is UiError && error != null) return error(status.message);
    return orElse();
  }

  TResult? whenOrNull<TResult>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(dynamic data)? success,
    TResult Function(String message)? error,
  }) {
    return maybeWhen(
      idle: idle,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }
}

class UiIdle extends UiStatus {
  const UiIdle();
}

class UiLoading extends UiStatus {
  const UiLoading();
}

class UiSuccess extends UiStatus {
  final dynamic data;
  const UiSuccess(this.data);
}

class UiError extends UiStatus {
  final String message;
  const UiError(this.message);
}
