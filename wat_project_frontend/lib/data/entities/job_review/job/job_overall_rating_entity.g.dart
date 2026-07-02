// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_overall_rating_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobOverallRatingEntity _$JobOverallRatingEntityFromJson(
  Map<String, dynamic> json,
) => JobOverallRatingEntity(
  ratingSummaryId: json['rating_summary_id'] as String,
  jobId: json['job_id'] as String,
  overallRate: (json['overall_rate'] as num).toDouble(),
  agencyRate: (json['agency_rate'] as num).toDouble(),
  jobRate: (json['job_rate'] as num).toDouble(),
  coworkersRate: (json['coworkers_rate'] as num).toDouble(),
  townRate: (json['town_rate'] as num).toDouble(),
  hoursRate: (json['hours_rate'] as num).toDouble(),
  housingRate: (json['housing_rate'] as num).toDouble(),
  secondJobFeasibilityRate: (json['second_job_feasibility_rate'] as num)
      .toDouble(),
  overtimeAvailabilityRate: (json['overtime_availability_rate'] as num)
      .toDouble(),
  reviewCount: (json['review_count'] as num).toInt(),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$JobOverallRatingEntityToJson(
  JobOverallRatingEntity instance,
) => <String, dynamic>{
  'rating_summary_id': instance.ratingSummaryId,
  'job_id': instance.jobId,
  'overall_rate': instance.overallRate,
  'agency_rate': instance.agencyRate,
  'job_rate': instance.jobRate,
  'coworkers_rate': instance.coworkersRate,
  'town_rate': instance.townRate,
  'hours_rate': instance.hoursRate,
  'housing_rate': instance.housingRate,
  'second_job_feasibility_rate': instance.secondJobFeasibilityRate,
  'overtime_availability_rate': instance.overtimeAvailabilityRate,
  'review_count': instance.reviewCount,
  'updated_at': instance.updatedAt.toIso8601String(),
};
