import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wat_project_frontend/core/extension/extension.dart';
import 'package:wat_project_frontend/domain/errors/auth_exception.dart';import 'package:wat_project_frontend/domain/services/auth_manager.dart';
class AuthInterceptor extends Interceptor {
  final AuthSessionManager _authManager;
  final Dio _authDio; // Used for refresh calls to avoid interceptor loop
  Completer<String>? _refreshCompleter;

  AuthInterceptor(this._authManager, {required Dio dio}) : _authDio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.needLogin) {
      return handler.next(options);
    }

    final session = _authManager.currentSession;

    if (session == null || session.isExpired) {
      await _authManager.clearSession();
      return handler.reject(
        DioException(
          requestOptions: options,
          error: SessionExpiredException(),
        ),
      );
    }

    if (_refreshCompleter != null) {
      try {
        final newToken = await _refreshCompleter!.future;
        options.headers['Authorization'] = 'Bearer $newToken';
        return handler.next(options);
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: QueuedRefreshFailedException(),
          ),
        );
      }
    }

    if (session.isNearExpiration) {
      try {
        final newToken = await _executeTokenRefresh();
        options.headers['Authorization'] = 'Bearer $newToken';
        return handler.next(options);
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: ProactiveRefreshFailedException(),
          ),
        );
      }
    }

    options.headers['Authorization'] = 'Bearer ${session.token}';
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.requestOptions.needLogin) {
      final session = _authManager.currentSession;
      
      // If token was already updated by another concurrent request, retry immediately
      if (session != null &&
          err.requestOptions.headers['Authorization'] != 'Bearer ${session.token}') {
        return _retry(err.requestOptions, handler, session.token);
      }

      try {
        final newToken = await _executeTokenRefresh();
        return _retry(err.requestOptions, handler, newToken);
      } catch (e) {
        await _authManager.clearSession();
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: AuthRetryFailedException(),
          ),
        );
      }
    }
    return handler.next(err);
  }

  Future<String> _executeTokenRefresh() async {
    if (_refreshCompleter != null) return _refreshCompleter!.future;

    _refreshCompleter = Completer<String>();
    try {
      final newSession = await _authManager.refreshSession();
      _refreshCompleter!.complete(newSession.token);
      return newSession.token;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _retry(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
    String token,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers..['Authorization'] = 'Bearer $token',
    );

    try {
      final response = await _authDio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
      return handler.resolve(response);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: requestOptions,
          error: AuthRetryFailedException(),
        ),
      );
    }
  }
}
