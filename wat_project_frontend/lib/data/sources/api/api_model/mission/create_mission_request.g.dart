// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_mission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMissionRequest _$CreateMissionRequestFromJson(
  Map<String, dynamic> json,
) => CreateMissionRequest(
  phaseId: json['phase_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  location: json['location'] as String?,
  basePoints: (json['base_points'] as num).toInt(),
  isMandatory: json['is_mandatory'] as bool,
  verificationType: json['verification_type'] as String,
  dueDateType: json['due_date_type'] as String?,
  fixedDueDate: json['fixed_due_date'] as String?,
  relativeTriggerEvent: json['relative_trigger_event'] as String?,
  relativeDaysOffset: (json['relative_days_offset'] as num?)?.toInt(),
  taskList: (json['taskList'] as List<dynamic>)
      .map((e) => CreateTaskRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateMissionRequestToJson(
  CreateMissionRequest instance,
) => <String, dynamic>{
  'phase_id': instance.phaseId,
  'title': instance.title,
  'description': instance.description,
  'location': instance.location,
  'base_points': instance.basePoints,
  'is_mandatory': instance.isMandatory,
  'verification_type': instance.verificationType,
  'due_date_type': instance.dueDateType,
  'fixed_due_date': instance.fixedDueDate,
  'relative_trigger_event': instance.relativeTriggerEvent,
  'relative_days_offset': instance.relativeDaysOffset,
  'taskList': instance.taskList,
};
