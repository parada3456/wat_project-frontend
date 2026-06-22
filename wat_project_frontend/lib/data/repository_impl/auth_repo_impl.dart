import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/auth_model.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/login_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/register_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/auth_refresh_request.dart';


@injectable
class AuthRepoImpl implements AuthRepository {
  final AuthApiService _api;

  AuthRepoImpl(this._api);

  @override
  Future<AuthModel> register(
      String email, String password, String firstName, String lastName) async {
    final response = await _api.register(RegisterRequest(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    ));
    return response.auth.toModel();
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await _api.login(LoginRequest(email: email, password: password));
    return response.auth.toModel();
  }

  @override
  Future<void> logout(String refreshToken) async {
    return _api.logout({'refresh_token': refreshToken});
  }

  @override
  Future<AuthModel> refresh(String refreshToken) async {
    final response = await _api.refresh(AuthRefreshRequest(refreshToken: refreshToken));
    return response.toModel();
  }

  @override
  Future<void> forgotPassword(String email) async {
    return _api.forgotPassword({'email': email});
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    return _api.resetPassword({
      'token': token,
      'new_password': newPassword,
    });
  }
}
