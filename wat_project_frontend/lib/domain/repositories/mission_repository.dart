import 'dart:io';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

abstract class MissionRepository {
  Future<List<MissionEntity>> listMissions();
  Future<List<UserMissionEntity>> listUserMissions();
  Future<List<MissionEntity>> listExploreMissions();
  Future<MissionDetailResponse> getMissionDetail(String id);
  Future<List<TaskEntity>> getTasksByIds(List<String> ids);
  Future<List<UserTaskEntity>> getUserTasksByIds(List<String> ids);
  Future<void> submitProof(String id, File file);
  Future<void> toggleTask(String userMissionId, String taskId, bool completed);
  Future<MissionModel> createMission(CreateMissionRequest request);
  Future<UserMissionModel> joinMission(String missionId);
}
