import 'package:wat_project_frontend/domain/models/mission_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/task_model.dart';
import 'package:wat_project_frontend/domain/models/user_task_model.dart';

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
