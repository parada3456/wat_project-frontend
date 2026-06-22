import 'dart:io';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';

abstract class MissionRepository {
  Future<List<UserMissionModel>> listMissions();
  Future<MissionDetailResponse> getMissionDetail(String id);
  Future<void> submitProof(String id, File file);
  Future<void> toggleTask(String userMissionId, String taskId, bool completed);
}
