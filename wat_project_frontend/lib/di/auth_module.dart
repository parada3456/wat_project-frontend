import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';

@module
abstract class AuthModule {
  // @singleton
  // AuthSessionManager authSessionManager(FlutterSecureStorage storage, AuthApiService api) =>
  //     AuthSessionManager(storage, api: api);
  @singleton
  AuthSessionManager authSessionManager(
    FlutterSecureStorage storage,
    AuthApiService api,
  ) {
    return AuthSessionManager(storage, api: api);
  }
}
