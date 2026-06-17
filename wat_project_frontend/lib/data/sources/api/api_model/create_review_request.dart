import 'package:json_annotation/json_annotation.dart';

part 'create_review_request.g.dart';

@JsonSerializable()
class CreateReviewRequest {
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'rating_stars')
  final double ratingStars;
  @JsonKey(name: 'review_text')
  final String reviewText;

  CreateReviewRequest({
    required this.jobId,
    required this.ratingStars,
    required this.reviewText,
  });

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateReviewRequestToJson(this);
}
