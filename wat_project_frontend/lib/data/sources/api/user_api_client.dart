import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user_profile_response.dart';import 'package:wat_project_frontend/data/sources/api/api_model/update_profile_request.dart';
import 'package:wat_project_frontend/data/entities/badge_entity.dart';
import 'package:wat_project_frontend/data/entities/point_ledger_entity.dart';

import 'package:wat_project_frontend/data/entities/user_entity.dart';

import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET('users/me')
  Future<UserProfileResponse> getProfile();

  @PATCH('users/me')
  Future<void> updateProfile(@Body() UpdateProfileRequest request);

  @PATCH('users/me/settings')
  Future<void> updateSettings(@Body() Map<String, dynamic> settings);

  @DELETE('users/me')
  Future<void> deleteAccount(@Body() Map<String, dynamic> body);

  @GET('users/{id}')
  Future<UserEntity> getUserPublicProfile(@Path('id') String id);

  @GET('user/badges')
  Future<ListResponse<BadgeEntity>> getBadges();

  @GET('user/points/ledger')
  Future<ListResponse<PointLedgerEntity>> getPointsLedger();

  @GET('user/credit-score/history')
  Future<ListResponse<PointLedgerEntity>> getCreditScoreHistory();

  @PATCH('profile/location')
  Future<void> updateLocation(@Body() Map<String, dynamic> body);
}
