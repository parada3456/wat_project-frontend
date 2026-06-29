import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/data/sources/api/mission_api_client.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/toggle_task_request.dart';


@injectable
class MissionRepoImpl implements MissionRepository {
  final MissionApiService _api;

  MissionRepoImpl(this._api);

  @override
  Future<List<UserMissionModel>> listMissions() async {
    final response = await _api.listMissions();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<MissionDetailResponse> getMissionDetail(String id) async {
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
  Future<void> submitProof(String id, File file) async {
    return _api.submitProof(id, file);
  }

  @override
  Future<void> toggleTask(String userMissionId, String taskId, bool completed) async {
    return _api.toggleTask(
      userMissionId,
      taskId,
      ToggleTaskRequest(completed: completed, isCompleted: completed),
    );
  }
}
