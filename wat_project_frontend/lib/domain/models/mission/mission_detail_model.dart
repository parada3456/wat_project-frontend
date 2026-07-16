import 'package:wat_project_frontend/domain/models/mission_models.dart';

class MissionDetailModel {
  final MissionModel mission;
  final UserMissionModel userMission;
  final List<TaskModel> tasks;
  final List<UserTaskModel> userTasks;

  const MissionDetailModel({
    required this.mission,
    required this.userMission,
    required this.tasks,
    required this.userTasks,
  });
}
