import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

part 'user_task_entity.g.dart';

@JsonSerializable()
class UserTaskEntity {
  @JsonKey(name: 'user_task_id')
  final String userTaskId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'task_id')
  final String taskId;
  @JsonKey(name: 'user_mission_id')
  final String userMissionId;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserTaskEntity({
    required this.userTaskId,
    required this.userId,
    required this.taskId,
    required this.userMissionId,
    required this.isCompleted,
    this.completedAt,
    required this.updatedAt,
  });

  factory UserTaskEntity.fromJson(Map<String, dynamic> json) => _$UserTaskEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserTaskEntityToJson(this);

  // UserTaskModel toModel() => UserTaskModel(
  //       userTaskId: userTaskId,
  //       userId: userId,
  //       taskId: taskId,
  //       userMissionId: userMissionId,
  //       isCompleted: isCompleted,
  //       completedAt: completedAt,
  //       updatedAt: updatedAt,
  //     );
}
