import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/user_mission_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';
part 'mission_api_client.g.dart';

@RestApi()
abstract class MissionApiService {
  factory MissionApiService(Dio dio, {String baseUrl}) = _MissionApiService;

  @GET('/missions')
  Future<List<UserMissionEntity>> listMissions();

  @GET('/missions/{id}')
  Future<MissionDetailResponse> getMissionDetail(@Path('id') String id);

  @POST('/missions/{id}/verify')
  @MultiPart()
  Future<void> submitProof(
    @Path('id') String id,
    @Part(name: 'proof') File file,
  );

  @PATCH('/tasks/{id}')
  Future<void> toggleTask(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}
