import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/admin_stats_entity.dart';
import 'package:wat_project_frontend/data/entities/user_entity.dart';
import 'package:wat_project_frontend/data/entities/points_adjustment_result_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/verify_mission_response.dart';

part 'admin_api_client.g.dart';

@RestApi()
abstract class AdminApiService {
  factory AdminApiService(Dio dio, {String baseUrl}) = _AdminApiService;

  @GET('/admin/dashboard/stats')
  Future<AdminStatsEntity> getStats();

  @GET('/admin/user-missions')
  Future<Map<String, dynamic>> listPendingVerifications();

  @PATCH('/admin/user-missions/{id}/verify')
  Future<VerifyMissionResponse> verifyMission(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @GET('/admin/users')
  Future<Map<String, dynamic>> listUsers(@Query('q') String search);

  @GET('/admin/users/{id}')
  Future<UserEntity> getUserDetail(@Path('id') String id);

  @POST('/admin/users/{id}/adjust-points')
  Future<PointsAdjustmentResultEntity> adjustPoints(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}
