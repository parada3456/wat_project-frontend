import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';

part 'job_review_entity.g.dart';

@JsonSerializable()
class JobReviewEntity {
  @JsonKey(name: 'review_id')
  final String reviewId;
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'rating_stars')
  final double ratingStars;
  @JsonKey(name: 'review_text')
  final String? reviewText;
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
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  JobReviewEntity({
    required this.reviewId,
    required this.jobId,
    required this.userId,
    required this.ratingStars,
    this.reviewText,
    this.tipsForNextGeneration,
    required this.scoreAgency,
    required this.scoreJob,
    required this.scoreCoworkers,
    required this.scoreTown,
    required this.scoreHours,
    required this.scoreHousing,
    required this.scoreSecondJobFeasibility,
    required this.scoreOvertimeAvailability,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobReviewEntity.fromJson(Map<String, dynamic> json) => _$JobReviewEntityFromJson(json);
  Map<String, dynamic> toJson() => _$JobReviewEntityToJson(this);

  JobReviewModel toModel() => JobReviewModel(
    reviewId: reviewId,
    jobId: jobId,
    userId: userId,
    ratingStars: ratingStars,
    reviewText: reviewText,
    tipsForNextGeneration: tipsForNextGeneration,
    scoreAgency: scoreAgency,
    scoreJob: scoreJob,
    scoreCoworkers: scoreCoworkers,
    scoreTown: scoreTown,
    scoreHours: scoreHours,
    scoreHousing: scoreHousing,
    scoreSecondJobFeasibility: scoreSecondJobFeasibility,
    scoreOvertimeAvailability: scoreOvertimeAvailability,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
