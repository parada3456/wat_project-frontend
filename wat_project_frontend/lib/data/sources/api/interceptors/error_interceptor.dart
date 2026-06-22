import 'package:dio/dio.dart';
import 'package:wat_project_frontend/core/error/exceptions.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response?.data != null) {
      try {
        final data = err.response!.data;
        if (data is Map<String, dynamic>) {
          final apiError = ApiError.fromJson(data);
          final apiException = ApiException(
            apiError: apiError,
            statusCode: err.response?.statusCode,
          );
          // Official Dio Pattern: Pass custom errors via err.copyWith or reject
          // Source: https://pub.dev/packages/dio#interceptors
          return handler.reject(err.copyWith(error: apiException));
        }
      } catch (e) {
        if (e is ApiException) {
          return handler.reject(err.copyWith(error: e));
        }
        return handler.reject(
            err.copyWith(error: const ServerException('Unexpected error format from server.')));
      }
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError) {
      return handler.reject(
          err.copyWith(error: const ServerException('No internet connection or server timeout.')));
    }

    return handler.next(err);
  }
}
