import 'dart:io';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

abstract class MissionRepository {
  /// All available missions (paginated).
  Future<PaginationResponse<MissionEntity>> listMissions({
    int page = 1,
    int pageSize = 20,
  });

  /// Missions the current user has joined (paginated).
  Future<PaginationResponse<MissionEntity>> listMyMissions({
    int page = 1,
    int pageSize = 20,
  });

  /// Explore / discovery feed (paginated).
  Future<PaginationResponse<MissionEntity>> listExploreMissions({
    int page = 1,
    int pageSize = 20,
  });

  Future<MissionEntity> getMissionDetail(String id);
  Future<List<TaskEntity>> getTasksByIds(List<String> ids);
  Future<List<UserTaskEntity>> getUserTasksByIds(List<String> ids);
  Future<void> submitProof(String id, File? file);
  Future<void> toggleTask(String userMissionId, String taskId, bool completed);
  Future<MissionEntity> createMission(CreateMissionRequest request);
  Future<MissionEntity> joinMission(String missionId);
}
