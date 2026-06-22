import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/user_mission_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';
part 'mission_api_client.g.dart';

@RestApi()
abstract class MissionApiService {
  factory MissionApiService(Dio dio, {String baseUrl}) = _MissionApiService;

  @GET('user-missions')
  Future<ListResponse<UserMissionEntity>> listMissions();

  @GET('user-missions/{id}')
  Future<MissionDetailResponse> getMissionDetail(@Path('id') String id);

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
    @Body() Map<String, dynamic> body,
  );
}
