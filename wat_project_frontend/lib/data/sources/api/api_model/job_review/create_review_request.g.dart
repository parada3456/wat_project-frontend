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
    );

Map<String, dynamic> _$CreateReviewRequestToJson(
  CreateReviewRequest instance,
) => <String, dynamic>{
  'job_id': instance.jobId,
  'rating_stars': instance.ratingStars,
  'review_text': instance.reviewText,
};
