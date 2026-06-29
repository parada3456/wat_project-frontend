import 'dart:io';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';

abstract class MissionRepository {
  Future<List<UserMissionModel>> listMissions();
  Future<MissionDetailResponse> getMissionDetail(String id);
  Future<List<TaskEntity>> getTasksByIds(List<String> ids);
  Future<List<UserTaskEntity>> getUserTasksByIds(List<String> ids);
  Future<void> submitProof(String id, File file);
  Future<void> toggleTask(String userMissionId, String taskId, bool completed);
}
