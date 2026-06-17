import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user_profile_response.dart';import 'package:wat_project_frontend/data/sources/api/api_model/update_profile_request.dart';
import 'package:wat_project_frontend/data/entities/badge_entity.dart';
import 'package:wat_project_frontend/data/entities/point_ledger_entity.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET('/user/profile')
  Future<UserProfileResponse> getProfile();

  @PATCH('/user/profile')
  Future<void> updateProfile(@Body() UpdateProfileRequest request);

  @PATCH('/user/settings')
  Future<void> updateSettings(@Body() Map<String, dynamic> settings);

  @DELETE('/user/account')
  Future<void> deleteAccount(@Body() Map<String, dynamic> body);

  @GET('/user/badges')
  Future<List<BadgeEntity>> getBadges();

  @GET('/user/credit-history')
  Future<List<PointLedgerEntity>> getCreditScoreHistory();

  @POST('/user/location')
  Future<void> updateLocation(@Body() Map<String, dynamic> body);
}
