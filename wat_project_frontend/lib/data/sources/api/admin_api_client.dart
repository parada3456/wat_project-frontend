import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/admin/admin_stats_entity.dart';
import 'package:wat_project_frontend/data/entities/auth_profile/profile/user_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/points_adjustment_result_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';

import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';
import 'package:wat_project_frontend/data/entities/mission/verify_mission_response.dart';
import 'package:wat_project_frontend/data/entities/auth_profile/profile/users_list_response.dart';

import 'package:wat_project_frontend/data/sources/api/api_model/admin/verify_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/admin/adjust_points_request.dart';

part 'admin_api_client.g.dart';

@RestApi()
abstract class AdminApiService {
  factory AdminApiService(Dio dio, {String baseUrl}) = _AdminApiService;

  @GET('admin/dashboard/stats')
  Future<AdminStatsEntity> getStats();

  @GET('admin/user-missions')
  Future<ListResponse<UserMissionEntity>> listPendingVerifications();

  @PATCH('admin/user-missions/{id}/verify')
  Future<VerifyMissionResponse> verifyMission(
    @Path('id') String id,
    @Body() VerifyMissionRequest request,
  );

  @GET('admin/users')
  Future<UsersListResponse> listUsers(@Query('q') String search);

  @GET('admin/users/{id}')
  Future<UserEntity> getUserDetail(@Path('id') String id);

  @POST('admin/users/{id}/adjust-points')
  Future<PointsAdjustmentResultEntity> adjustPoints(
    @Path('id') String id,
    @Body() AdjustPointsRequest request,
  );
}
