// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleTaskRequest _$ToggleTaskRequestFromJson(Map<String, dynamic> json) =>
    ToggleTaskRequest(
      completed: json['completed'] as bool,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$ToggleTaskRequestToJson(ToggleTaskRequest instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'isCompleted': instance.isCompleted,
    };
