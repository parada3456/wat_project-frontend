// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_housing_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobHousingEntity _$JobHousingEntityFromJson(Map<String, dynamic> json) =>
    JobHousingEntity(
      housingId: json['housing_id'] as String,
      jobId: json['job_id'] as String,
      description: json['description'] as String?,
      weeklyRate: (json['weekly_rate'] as num).toDouble(),
      deposit: (json['deposit'] as num).toDouble(),
      transportation: json['transportation'] as String?,
      rangeMinStartDate: json['range_min_start_date'] as String?,
      rangeMaxStartDate: json['range_max_start_date'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$JobHousingEntityToJson(JobHousingEntity instance) =>
    <String, dynamic>{
      'housing_id': instance.housingId,
      'job_id': instance.jobId,
      'description': instance.description,
      'weekly_rate': instance.weeklyRate,
      'deposit': instance.deposit,
      'transportation': instance.transportation,
      'range_min_start_date': instance.rangeMinStartDate,
      'range_max_start_date': instance.rangeMaxStartDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
