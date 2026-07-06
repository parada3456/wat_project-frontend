// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewScoreModel _$ReviewScoreModelFromJson(Map<String, dynamic> json) =>
    ReviewScoreModel(
      agency: (json['agency'] as num).toDouble(),
      job: (json['job'] as num).toDouble(),
      coworkers: (json['coworkers'] as num).toDouble(),
      town: (json['town'] as num).toDouble(),
      hours: (json['hours'] as num).toDouble(),
      housing: (json['housing'] as num).toDouble(),
      secondJobFeasibility: (json['second_job_feasibility'] as num).toDouble(),
      overtimeAvailability: (json['overtime_availability'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewScoreModelToJson(ReviewScoreModel instance) =>
    <String, dynamic>{
      'agency': instance.agency,
      'job': instance.job,
      'coworkers': instance.coworkers,
      'town': instance.town,
      'hours': instance.hours,
      'housing': instance.housing,
      'second_job_feasibility': instance.secondJobFeasibility,
      'overtime_availability': instance.overtimeAvailability,
    };
