import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/toggle_task_request.dart';
part 'mission_api_client.g.dart';

@RestApi()
abstract class MissionApiService {
  factory MissionApiService(Dio dio, {String baseUrl}) = _MissionApiService;

  @GET('user-missions')
  Future<PaginationResponse<UserMissionEntity>> listMissions();

  @GET('user-missions/{id}')
  Future<MissionDetailResponse> getMissionDetail(@Path('id') String id);

  @GET('tasks')
  Future<PaginationResponse<TaskEntity>> getTasksByIds(@Query('ids') String ids);

  @GET('user-tasks')
  Future<PaginationResponse<UserTaskEntity>> getUserTasksByIds(@Query('ids') String ids);

  @POST('user-missions/{id}/proof')
  @MultiPart()
  Future<void> submitProof(
    @Path('id') String id,
    @Part(name: 'proof') File file,
  );

  @PATCH('user-missions/{id}/tasks/{taskId}')
  Future<void> toggleTask(
    @Path('id') String userMissionId,
    @Path('taskId') String taskId,
    @Body() ToggleTaskRequest request,
  );
}
