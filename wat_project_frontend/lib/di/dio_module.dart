import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/services/auth_interceptor.dart';import 'package:wat_project_frontend/domain/services/auth_manager.dart';
@module
abstract class DioModule {
  @Named('authDio')
  @lazySingleton
  Dio authDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api/v1', // Update based on environment
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    // Add logging interceptor if needed
    return dio;
  }

  @Named('mainDio')
  @lazySingleton
  Dio mainDio(@Named('authDio') Dio authDio, AuthSessionManager authManager) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api/v1',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptor(authManager, dio: authDio));
    return dio;
  }
}
