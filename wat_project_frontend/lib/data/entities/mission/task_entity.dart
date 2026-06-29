import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/task_model.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  @JsonKey(name: 'task_id')
  final String taskId;
  @JsonKey(name: 'mission_id')
  final String missionId;
  final String title;
  final String? description;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  TaskEntity({
    required this.taskId,
    required this.missionId,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) => _$TaskEntityFromJson(json);

  TaskModel toModel() => TaskModel(
        taskId: taskId,
        missionId: missionId,
        title: title,
        description: description,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );
}
