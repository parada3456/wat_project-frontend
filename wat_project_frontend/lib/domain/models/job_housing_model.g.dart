// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_housing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobHousingModel _$JobHousingModelFromJson(Map<String, dynamic> json) =>
    JobHousingModel(
      housingId: json['housingId'] as String,
      jobId: json['jobId'] as String,
      description: json['description'] as String?,
      weeklyRate: (json['weeklyRate'] as num?)?.toDouble() ?? 0.0,
      deposit: (json['deposit'] as num?)?.toDouble() ?? 0.0,
      transportation: json['transportation'] as String?,
      rangeMinStartDate: json['rangeMinStartDate'] == null
          ? null
          : DateTime.parse(json['rangeMinStartDate'] as String),
      rangeMaxStartDate: json['rangeMaxStartDate'] == null
          ? null
          : DateTime.parse(json['rangeMaxStartDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobHousingModelToJson(JobHousingModel instance) =>
    <String, dynamic>{
      'housingId': instance.housingId,
      'jobId': instance.jobId,
      'description': instance.description,
      'weeklyRate': instance.weeklyRate,
      'deposit': instance.deposit,
      'transportation': instance.transportation,
      'rangeMinStartDate': instance.rangeMinStartDate?.toIso8601String(),
      'rangeMaxStartDate': instance.rangeMaxStartDate?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
