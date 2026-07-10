import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';
import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/auth_refresh_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/login_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/register_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/logout_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/forgot_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/reset_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/authentication/google_login_request.dart';
part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('auth/register')
  @Extra({'needLogin': false})
  Future<LoginEntity> register(@Body() RegisterRequest request);

  @POST('auth/login')
  @Extra({'needLogin': false})
  Future<LoginEntity> login(@Body() LoginRequest request);

  @POST('auth/google')
  @Extra({'needLogin': false})
  Future<LoginEntity> googleLogin(@Body() GoogleLoginRequest request);

  @POST('auth/logout')
  Future<void> logout(@Body() LogoutRequest request);

  @POST('auth/refresh')
  @Extra({'needLogin': false})
  Future<AuthEntity> refresh(@Body() AuthRefreshRequest request);

  @POST('auth/forgot-password')
  @Extra({'needLogin': false})
  Future<void> forgotPassword(@Body() ForgotPasswordRequest request);

  @POST('auth/reset-password')
  @Extra({'needLogin': false})
  Future<void> resetPassword(@Body() ResetPasswordRequest request);
}
