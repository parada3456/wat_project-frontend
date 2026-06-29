import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/user/profile_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_profile_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/assign_job_request.dart';

import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_settings_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/delete_account_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_location_request.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET('users/me')
  Future<UserProfileEntity> getProfile();

  @DELETE('users/me')
  Future<void> deleteAccount(@Body() DeleteAccountRequest request);

  @PATCH('users/me')
  Future<void> updateProfile(@Body() UpdateProfileRequest updateProfileRequest);

  @PATCH('users/me/settings')
  Future<void> updateSettings(@Body() UpdateSettingsRequest request);

  @GET('users/{id}')
  Future<ProfileEntity> getUserPublicProfile(@Path('id') String id);

  @GET('user/badges')
  Future<PaginationResponse<BadgeEntity>> getBadges();

  @GET('user/points/ledger')
  Future<PaginationResponse<PointLedgerEntity>> getPointsLedger();

  @GET('user/credit-score/history')
  Future<PaginationResponse<PointLedgerEntity>> getCreditScoreHistory();

  @PATCH('profile/location')
  Future<void> updateLocation(@Body() UpdateLocationRequest request);

  @POST('users/me/job')
  Future<void> assignJob(@Body() AssignJobRequest request);

  @PUT('users/me/password')
  Future<void> updatePassword(@Body() UpdatePasswordRequest request);
}
