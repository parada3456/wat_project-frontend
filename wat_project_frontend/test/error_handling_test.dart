import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/field_error.dart';
import 'package:wat_project_frontend/data/sources/api/interceptors/error_interceptor.dart';
import 'package:wat_project_frontend/core/error/exceptions.dart';

// Fake ErrorInterceptorHandler to capture the rejected error
class FakeErrorInterceptorHandler extends ErrorInterceptorHandler {
  DioException? rejectedError;
  DioException? nextError;

  @override
  void reject(DioException error) {
    rejectedError = error;
  }

  @override
  void next(DioException error) {
    nextError = error;
  }
}

void main() {
  group('Error Handling Tests', () {
    test('ApiError parses correctly from standard JSON format', () {
      final json = {
        "error": {
          "code": "validation_error",
          "message": "One or more fields failed validation.",
          "details": [
            { "field": "email", "reason": "must be a valid email address" },
            { "field": "password", "reason": "must be at least 8 characters" }
          ]
        }
      };

      final apiError = ApiError.fromJson(json['error'] as Map<String, dynamic>);

      expect(apiError.code, 'validation_error');
      expect(apiError.message, 'One or more fields failed validation.');
      expect(apiError.details.length, 2);
      expect(apiError.details[0].field, 'email');
      expect(apiError.details[0].reason, 'must be a valid email address');
    });

    test('ErrorInterceptor intercepts DioException and parses to ApiException', () {
      final interceptor = ErrorInterceptor();
      final handler = FakeErrorInterceptorHandler();

      final requestOptions = RequestOptions(path: '/api/login');
      final responseData = {
        "error": {
          "code": "validation_error",
          "message": "One or more fields failed validation.",
          "details": [
            { "field": "email", "reason": "must be a valid email address" }
          ]
        }
      };
      
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(
          requestOptions: requestOptions,
          statusCode: 400,
          data: responseData,
        ),
        type: DioExceptionType.badResponse,
      );

      interceptor.onError(dioException, handler);

      expect(handler.rejectedError, isNotNull);
      final finalError = handler.rejectedError!.error;
      
      expect(finalError, isA<ApiException>());
      
      final apiException = finalError as ApiException;
      expect(apiException.statusCode, 400);
      expect(apiException.apiError.code, 'validation_error');
      expect(apiException.apiError.details.first.field, 'email');
    });
  });
}
