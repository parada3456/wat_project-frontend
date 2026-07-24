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
  @JsonKey(name: 'tips_for_next_generation')
  final String? tipsForNextGeneration;
  @JsonKey(name: 'score_agency')
  final double scoreAgency;
  @JsonKey(name: 'score_job')
  final double scoreJob;
  @JsonKey(name: 'score_coworkers')
  final double scoreCoworkers;
  @JsonKey(name: 'score_town')
  final double scoreTown;
  @JsonKey(name: 'score_hours')
  final double scoreHours;
  @JsonKey(name: 'score_housing')
  final double scoreHousing;
  @JsonKey(name: 'score_second_job_feasibility')
  final double scoreSecondJobFeasibility;
  @JsonKey(name: 'score_overtime_availability')
  final double scoreOvertimeAvailability;

  CreateReviewRequest({
    required this.jobId,
    required this.ratingStars,
    required this.reviewText,
    this.tipsForNextGeneration,
    required this.scoreAgency,
    required this.scoreJob,
    required this.scoreCoworkers,
    required this.scoreTown,
    required this.scoreHours,
    required this.scoreHousing,
    required this.scoreSecondJobFeasibility,
    required this.scoreOvertimeAvailability,
  });

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateReviewRequestToJson(this);
}
