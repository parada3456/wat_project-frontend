import 'package:json_annotation/json_annotation.dart';

part 'create_review_alternative_request.g.dart';

@JsonSerializable()
class CreateReviewAlternativeRequest {
  @JsonKey(name: 'job_id')
  final String? jobId;
  @JsonKey(name: 'rating_stars')
  final double? ratingStars;
  @JsonKey(name: 'review_text')
  final String? reviewText;

  CreateReviewAlternativeRequest({
    this.jobId,
    this.ratingStars,
    this.reviewText,
  });

  factory CreateReviewAlternativeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewAlternativeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateReviewAlternativeRequestToJson(this);
}
