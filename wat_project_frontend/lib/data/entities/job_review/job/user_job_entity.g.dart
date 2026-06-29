// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJobEntity _$UserJobEntityFromJson(Map<String, dynamic> json) =>
    UserJobEntity(
      userId: json['user_id'] as String,
      jobId: json['job_id'] as String,
      assignedAt: json['assigned_at'] as String,
      isMain: json['is_main'] as bool,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$UserJobEntityToJson(UserJobEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'job_id': instance.jobId,
      'assigned_at': instance.assignedAt,
      'is_main': instance.isMain,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
