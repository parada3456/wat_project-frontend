import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/data/sources/api/mission_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/toggle_task_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/join_mission_request.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

@injectable
class MissionRepoImpl implements MissionRepository {
  final MissionApiService _api;

  MissionRepoImpl(this._api);

  @override
  Future<PaginationResponse<MissionEntity>> listMissions({
    int? page,
    int pageSize = 20,
  }) async {
    try {
      return await _api.listMissions(page: page, pageSize: pageSize);
    } catch (e, stackTrace) {
      print('🚨 listMissions ERROR: $e');
      print('📋 STACK TRACE:\n$stackTrace');
      rethrow;
    }
  }

  @override
  Future<PaginationResponse<MissionEntity>> listMyMissions({
    int? page,
    int pageSize = 20,
    int? limit,
  }) async {
    return _api.listMyMissions(page: page, pageSize: pageSize, limit: limit);
  }

  @override
  Future<PaginationResponse<MissionEntity>> listExploreMissions({
    int? page,
    int pageSize = 20,
  }) async {
    return _api.listExploreMissions(page: page, pageSize: pageSize);
  }

  @override
  Future<MissionEntity> getMissionDetail(String id) async {
    return _api.getMissionDetail(id);
  }

  @override
  Future<List<TaskEntity>> getTasksByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final response = await _api.getTasksByIds(ids.join(','));
    return response.data;
  }

  @override
  Future<List<UserTaskEntity>> getUserTasksByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final response = await _api.getUserTasksByIds(ids.join(','));
    return response.data;
  }

  @override
  Future<void> submitProof(String id, File? file) async {
    return _api.submitProof(id, file);
  }

  @override
  Future<void> toggleTask(
    String userMissionId,
    String taskId,
    bool completed,
  ) async {
    return _api.toggleTask(
      userMissionId,
      taskId,
      ToggleTaskRequest(completed: completed),
    );
  }

  @override
  Future<MissionEntity> createMission(CreateMissionRequest request) async {
    return _api.createMission(request);
  }

  @override
  Future<MissionEntity> joinMission(String missionId) async {
    return _api.joinMission(JoinMissionRequest(missionId: missionId));
  }
}
