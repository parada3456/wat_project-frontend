import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';

part 'mission_detail_response.g.dart';

@JsonSerializable()
class MissionDetailResponse {
  final MissionEntity mission;
  @JsonKey(name: 'user_mission')
  final UserMissionEntity? userMission;
  final List<TaskEntity> tasks;
  @JsonKey(name: 'user_tasks')
  final List<UserTaskEntity> userTasks;

  MissionDetailResponse({
    required this.mission,
    this.userMission,
    required this.tasks,
    required this.userTasks,
  });

  factory MissionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MissionDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MissionDetailResponseToJson(this);

  // MissionEntity toEntity() {
  //   return MissionEntity(
  //     missionId: mission.missionId,
  //     phaseId: mission.phaseId,
  //     title: mission.title,
  //     description: mission.description,
  //     location: mission.location,
  //     basePoints: mission.basePoints,
  //     isMandatory: mission.isMandatory,
  //     verificationType: mission.verificationType,
  //     isActive: mission.isActive,
  //     isLocked: mission.isLocked,
  //     createdAt: mission.createdAt,
  //     updatedAt: mission.updatedAt,
  //     userMission: userMission,
  //     tasks: tasks,
  //   );
  // }
}
