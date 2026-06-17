import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/auth_entity.dart';import 'package:wat_project_frontend/data/entities/login_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/auth_refresh_request.dart';import 'package:wat_project_frontend/data/sources/api/api_model/login_request.dart';import 'package:wat_project_frontend/data/sources/api/api_model/register_request.dart';
part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/auth/register')
  @Extra({'needLogin': false})
  Future<LoginEntity> register(@Body() RegisterRequest request);

  @POST('/auth/login')
  @Extra({'needLogin': false})
  Future<LoginEntity> login(@Body() LoginRequest request);

  @POST('/auth/logout')
  Future<void> logout();

  @POST('/auth/refresh')
  @Extra({'needLogin': false})
  Future<AuthEntity> refresh(@Body() AuthRefreshRequest request);

  @POST('/auth/forgot-password')
  @Extra({'needLogin': false})
  Future<void> forgotPassword(@Body() Map<String, dynamic> body);

  @POST('/auth/reset-password')
  @Extra({'needLogin': false})
  Future<void> resetPassword(@Body() Map<String, dynamic> body);
}
