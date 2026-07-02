// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedJobEntity _$AssignedJobEntityFromJson(Map<String, dynamic> json) =>
    AssignedJobEntity(
      userId: json['user_id'] as String,
      jobId: json['job_id'] as String,
      assignedAt: DateTime.parse(json['assigned_at'] as String),
      isMain: json['is_main'] as bool,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$AssignedJobEntityToJson(AssignedJobEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'job_id': instance.jobId,
      'assigned_at': instance.assignedAt.toIso8601String(),
      'is_main': instance.isMain,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };
