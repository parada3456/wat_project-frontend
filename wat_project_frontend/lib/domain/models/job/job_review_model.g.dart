// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobReviewModel _$JobReviewModelFromJson(Map<String, dynamic> json) =>
    JobReviewModel(
      reviewId: json['reviewId'] as String,
      jobId: json['jobId'] as String,
      userId: json['userId'] as String,
      ratingStars: (json['ratingStars'] as num?)?.toDouble() ?? 0.0,
      reviewText: json['reviewText'] as String?,
      tipsForNextGeneration: json['tipsForNextGeneration'] as String?,
      scoreAgency: (json['scoreAgency'] as num?)?.toDouble() ?? 0.0,
      scoreJob: (json['scoreJob'] as num?)?.toDouble() ?? 0.0,
      scoreCoworkers: (json['scoreCoworkers'] as num?)?.toDouble() ?? 0.0,
      scoreTown: (json['scoreTown'] as num?)?.toDouble() ?? 0.0,
      scoreHours: (json['scoreHours'] as num?)?.toDouble() ?? 0.0,
      scoreHousing: (json['scoreHousing'] as num?)?.toDouble() ?? 0.0,
      scoreSecondJobFeasibility:
          (json['scoreSecondJobFeasibility'] as num?)?.toDouble() ?? 0.0,
      scoreOvertimeAvailability:
          (json['scoreOvertimeAvailability'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobReviewModelToJson(JobReviewModel instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'jobId': instance.jobId,
      'userId': instance.userId,
      'ratingStars': instance.ratingStars,
      'reviewText': instance.reviewText,
      'tipsForNextGeneration': instance.tipsForNextGeneration,
      'scoreAgency': instance.scoreAgency,
      'scoreJob': instance.scoreJob,
      'scoreCoworkers': instance.scoreCoworkers,
      'scoreTown': instance.scoreTown,
      'scoreHours': instance.scoreHours,
      'scoreHousing': instance.scoreHousing,
      'scoreSecondJobFeasibility': instance.scoreSecondJobFeasibility,
      'scoreOvertimeAvailability': instance.scoreOvertimeAvailability,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
