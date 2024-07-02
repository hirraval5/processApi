typedef LoadingCallback = void Function(bool loading);
typedef ErrorCallback = void Function(Object? error, StackTrace stackTrace);

abstract mixin class BaseService {
  Future<T?> processApi<T>(
    Future<T?> Function() request, {
    LoadingCallback? onLoading,
    ErrorCallback? onError,
  }) async {
    onLoading?.call(true);
    final result = await request().onError(
      (error, stackTrace) {
        if (error != null) {
          onError?.call(error, stackTrace);
        }
        return null;
      },
    );
    onLoading?.call(false);
    return result;
  }
}
