// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_job_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignJobRequest _$AssignJobRequestFromJson(Map<String, dynamic> json) =>
    AssignJobRequest(
      jobId: json['job_id'] as String,
      isMain: json['is_main'] as bool,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$AssignJobRequestToJson(AssignJobRequest instance) =>
    <String, dynamic>{
      'job_id': instance.jobId,
      'is_main': instance.isMain,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
