import 'package:dio/dio.dart';
import 'package:wat_project_frontend/core/error/exceptions.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class BackendFailure extends Failure {
  final int? statusCode;
  final ApiError? apiError;

  const BackendFailure(super.message, {this.statusCode, this.apiError});
}

Failure mapExceptionToFailure(Object e) {
  if (e is DioException) {
    if (e.error is ApiException) {
      final apiEx = e.error as ApiException;
      return BackendFailure(
        apiEx.apiError.message,
        statusCode: apiEx.statusCode,
        apiError: apiEx.apiError,
      );
    } else if (e.error is ServerException) {
      return ServerFailure((e.error as ServerException).message);
    }
    return ServerFailure(e.message ?? 'Unknown network error occurred');
  }
  return ServerFailure(e.toString());
}
