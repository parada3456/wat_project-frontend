// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTaskEntity _$UserTaskEntityFromJson(Map<String, dynamic> json) =>
    UserTaskEntity(
      userTaskId: json['user_task_id'] as String,
      userId: json['user_id'] as String,
      taskId: json['task_id'] as String,
      userMissionId: json['user_mission_id'] as String,
      isCompleted: json['is_completed'] as bool,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserTaskEntityToJson(UserTaskEntity instance) =>
    <String, dynamic>{
      'user_task_id': instance.userTaskId,
      'user_id': instance.userId,
      'task_id': instance.taskId,
      'user_mission_id': instance.userMissionId,
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt?.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
