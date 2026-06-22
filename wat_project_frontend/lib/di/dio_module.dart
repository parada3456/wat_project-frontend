import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/services/auth_interceptor.dart';import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/data/sources/api/interceptors/error_interceptor.dart';

String get _baseUrl {
  if (kIsWeb) {
    return 'http://localhost:3456/api/v1/';
  }
  return defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:3456/api/v1/'
      : 'http://localhost:3456/api/v1/';
}

@module
abstract class DioModule {
  @Named('authDio')
  @lazySingleton
  Dio authDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(ErrorInterceptor());
    // Add logging interceptor if needed
    return dio;
  }

  @Named('mainDio')
  @lazySingleton
  Dio mainDio(@Named('authDio') Dio authDio, AuthSessionManager authManager) {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptor(authManager, dio: authDio));
    dio.interceptors.add(ErrorInterceptor());
    return dio;
  }
}
