// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_alternative_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewAlternativeRequest _$CreateReviewAlternativeRequestFromJson(
  Map<String, dynamic> json,
) => CreateReviewAlternativeRequest(
  jobId: json['job_id'] as String?,
  ratingStars: (json['rating_stars'] as num?)?.toDouble(),
  reviewText: json['review_text'] as String?,
);

Map<String, dynamic> _$CreateReviewAlternativeRequestToJson(
  CreateReviewAlternativeRequest instance,
) => <String, dynamic>{
  'job_id': instance.jobId,
  'rating_stars': instance.ratingStars,
  'review_text': instance.reviewText,
};
