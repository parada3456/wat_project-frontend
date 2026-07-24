// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) =>
    CreateReviewRequest(
      jobId: json['job_id'] as String,
      ratingStars: (json['rating_stars'] as num).toDouble(),
      reviewText: json['review_text'] as String,
      tipsForNextGeneration: json['tips_for_next_generation'] as String?,
      scoreAgency: (json['score_agency'] as num).toDouble(),
      scoreJob: (json['score_job'] as num).toDouble(),
      scoreCoworkers: (json['score_coworkers'] as num).toDouble(),
      scoreTown: (json['score_town'] as num).toDouble(),
      scoreHours: (json['score_hours'] as num).toDouble(),
      scoreHousing: (json['score_housing'] as num).toDouble(),
      scoreSecondJobFeasibility: (json['score_second_job_feasibility'] as num)
          .toDouble(),
      scoreOvertimeAvailability: (json['score_overtime_availability'] as num)
          .toDouble(),
    );

Map<String, dynamic> _$CreateReviewRequestToJson(
  CreateReviewRequest instance,
) => <String, dynamic>{
  'job_id': instance.jobId,
  'rating_stars': instance.ratingStars,
  'review_text': instance.reviewText,
  'tips_for_next_generation': instance.tipsForNextGeneration,
  'score_agency': instance.scoreAgency,
  'score_job': instance.scoreJob,
  'score_coworkers': instance.scoreCoworkers,
  'score_town': instance.scoreTown,
  'score_hours': instance.scoreHours,
  'score_housing': instance.scoreHousing,
  'score_second_job_feasibility': instance.scoreSecondJobFeasibility,
  'score_overtime_availability': instance.scoreOvertimeAvailability,
};
