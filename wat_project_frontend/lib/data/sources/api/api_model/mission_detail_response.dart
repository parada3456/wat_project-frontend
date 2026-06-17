import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/mission_entity.dart';import 'package:wat_project_frontend/data/entities/user_mission_entity.dart';import 'package:wat_project_frontend/data/entities/task_entity.dart';import 'package:wat_project_frontend/data/entities/user_task_entity.dart';
part 'mission_detail_response.g.dart';

@JsonSerializable()
class MissionDetailResponse {
  final MissionEntity mission;
  @JsonKey(name: 'user_mission')
  final UserMissionEntity userMission;
  final List<TaskEntity> tasks;
  @JsonKey(name: 'user_tasks')
  final List<UserTaskEntity> userTasks;

  MissionDetailResponse({
    required this.mission,
    required this.userMission,
    required this.tasks,
    required this.userTasks,
  });

  factory MissionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MissionDetailResponseFromJson(json);
}
