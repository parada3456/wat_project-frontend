// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) => TaskEntity(
  taskId: json['task_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  isCompleted: json['is_completed'] as bool?,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$TaskEntityToJson(TaskEntity instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'title': instance.title,
      'description': instance.description,
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt?.toIso8601String(),
    };
