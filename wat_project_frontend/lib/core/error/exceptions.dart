import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';

class ApiException implements Exception {
  final ApiError apiError;
  final int? statusCode;

  const ApiException({required this.apiError, this.statusCode});

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, error: ${apiError.toJson()})';
  }
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => message;
}
