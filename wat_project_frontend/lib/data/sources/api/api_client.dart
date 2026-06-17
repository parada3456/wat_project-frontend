import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/user_entity.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/user/me')
  Future<UserEntity> getMe();
}
