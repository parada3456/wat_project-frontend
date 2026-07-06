import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';
import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/login_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/register_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/auth_refresh_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/logout_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/forgot_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/reset_password_request.dart';


@injectable
class AuthRepoImpl implements AuthRepository {
  final AuthApiService _api;

  AuthRepoImpl(this._api);

  @override
  Future<LoginEntity> register(
    String email, String password, String firstName, String lastName) async {
    final response = await _api.register(RegisterRequest(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    ));
    return response;
  }

  @override
  Future<LoginEntity> login(String email, String password) async {
      final response = await _api.login(LoginRequest(email: email, password: password));
      return response;
  }

  @override
  Future<void> logout(String refreshToken) async {
    return _api.logout(LogoutRequest(refreshToken: refreshToken));
  }

  @override
  Future<AuthEntity> refresh(String refreshToken) async {
    final response = await _api.refresh(AuthRefreshRequest(refreshToken: refreshToken));
    return response;
  }

  @override
  Future<void> forgotPassword(String email) async {
    return _api.forgotPassword(ForgotPasswordRequest(email: email));
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    return _api.resetPassword(ResetPasswordRequest(
      token: token,
      newPassword: newPassword,
    ));
  }
}
