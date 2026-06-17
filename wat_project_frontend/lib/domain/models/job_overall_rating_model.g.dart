// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_overall_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobOverallRatingModel _$JobOverallRatingModelFromJson(
  Map<String, dynamic> json,
) => JobOverallRatingModel(
  ratingSummaryId: json['ratingSummaryId'] as String,
  jobId: json['jobId'] as String,
  overallRate: (json['overallRate'] as num?)?.toDouble() ?? 0.0,
  agencyRate: (json['agencyRate'] as num?)?.toDouble() ?? 0.0,
  jobRate: (json['jobRate'] as num?)?.toDouble() ?? 0.0,
  coworkersRate: (json['coworkersRate'] as num?)?.toDouble() ?? 0.0,
  townRate: (json['townRate'] as num?)?.toDouble() ?? 0.0,
  hoursRate: (json['hoursRate'] as num?)?.toDouble() ?? 0.0,
  housingRate: (json['housingRate'] as num?)?.toDouble() ?? 0.0,
  secondJobFeasibilityRate:
      (json['secondJobFeasibilityRate'] as num?)?.toDouble() ?? 0.0,
  overtimeAvailabilityRate:
      (json['overtimeAvailabilityRate'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$JobOverallRatingModelToJson(
  JobOverallRatingModel instance,
) => <String, dynamic>{
  'ratingSummaryId': instance.ratingSummaryId,
  'jobId': instance.jobId,
  'overallRate': instance.overallRate,
  'agencyRate': instance.agencyRate,
  'jobRate': instance.jobRate,
  'coworkersRate': instance.coworkersRate,
  'townRate': instance.townRate,
  'hoursRate': instance.hoursRate,
  'housingRate': instance.housingRate,
  'secondJobFeasibilityRate': instance.secondJobFeasibilityRate,
  'overtimeAvailabilityRate': instance.overtimeAvailabilityRate,
  'reviewCount': instance.reviewCount,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
