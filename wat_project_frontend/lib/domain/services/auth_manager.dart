import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/auth_refresh_request.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';

class AuthSessionManager {
  final FlutterSecureStorage _storage;
  final AuthApiService _api;

  static const String _sessionKey = 'auth_session';
  static const String _userIdKey = 'user_id';

  final ValueNotifier<AuthModel?> sessionNotifier = ValueNotifier(null);
  String? _userId;

  AuthSessionManager(this._storage, {required AuthApiService api}) : _api = api;

  AuthModel? get currentSession => sessionNotifier.value;
  String? get userId => _userId;

  bool get isAdmin {
    final session = currentSession;
    if (session == null) return false;
    final parts = session.token.split('.');
    if (parts.length >= 2) {
      try {
        final payload = parts[1];
        final normalized = base64.normalize(payload);
        final decoded = utf8.decode(base64Decode(normalized));
        final Map<String, dynamic> claims =
            jsonDecode(decoded) as Map<String, dynamic>;
        return claims['is_admin'] == true;
      } catch (_) {}
    }
    return false;
  }

  Future<void> initialize() async {
    final sessionJson = await _storage.read(key: _sessionKey);
    if (sessionJson != null) {
      try {
        final session = AuthModel.fromJson(
          jsonDecode(sessionJson) as Map<String, dynamic>,
        );
        sessionNotifier.value = session;
        _userId = await _storage.read(key: _userIdKey);
      } catch (e) {
        await clearSession();
      }
    }
  }

  Future<void> saveSession(AuthModel session, String? userId) async {
    await _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));
    if (userId != null) {
      await _storage.write(key: _userIdKey, value: userId);
      _userId = userId;
    }
    sessionNotifier.value = session;
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
    await _storage.delete(key: _userIdKey);
    _userId = null;
    sessionNotifier.value = null;
  }

  Future<AuthModel> refreshSession() async {
    final session = currentSession;
    if (session == null) throw Exception('No session to refresh');

    final response = await _api.refresh(
      AuthRefreshRequest(refreshToken: session.refreshToken),
    );

    final newSession = response.toModel();
    await saveSession(newSession, _userId);
    return newSession;
  }
}
