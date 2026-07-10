import 'package:json_annotation/json_annotation.dart';

part 'job_review_model.g.dart';

@JsonSerializable()
class JobReviewModel {
  final String reviewId;
  final String jobId;
  final String userId;
  final double ratingStars;
  final String? reviewText;
  final String? tipsForNextGeneration;
  final double scoreAgency;
  final double scoreJob;
  final double scoreCoworkers;
  final double scoreTown;
  final double scoreHours;
  final double scoreHousing;
  final double scoreSecondJobFeasibility;
  final double scoreOvertimeAvailability;
  final DateTime createdAt;
  final DateTime updatedAt;

  const JobReviewModel({
    required this.reviewId,
    required this.jobId,
    required this.userId,
    this.ratingStars = 0.0,
    this.reviewText,
    this.tipsForNextGeneration,
    this.scoreAgency = 0.0,
    this.scoreJob = 0.0,
    this.scoreCoworkers = 0.0,
    this.scoreTown = 0.0,
    this.scoreHours = 0.0,
    this.scoreHousing = 0.0,
    this.scoreSecondJobFeasibility = 0.0,
    this.scoreOvertimeAvailability = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobReviewModel.fromJson(Map<String, dynamic> json) =>
      _$JobReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobReviewModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobReviewModel &&
          runtimeType == other.runtimeType &&
          reviewId == other.reviewId &&
          jobId == other.jobId &&
          userId == other.userId &&
          ratingStars == other.ratingStars &&
          reviewText == other.reviewText &&
          tipsForNextGeneration == other.tipsForNextGeneration &&
          scoreAgency == other.scoreAgency &&
          scoreJob == other.scoreJob &&
          scoreCoworkers == other.scoreCoworkers &&
          scoreTown == other.scoreTown &&
          scoreHours == other.scoreHours &&
          scoreHousing == other.scoreHousing &&
          scoreSecondJobFeasibility == other.scoreSecondJobFeasibility &&
          scoreOvertimeAvailability == other.scoreOvertimeAvailability &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hashAll([
    reviewId,
    jobId,
    userId,
    ratingStars,
    reviewText,
    tipsForNextGeneration,
    scoreAgency,
    scoreJob,
    scoreCoworkers,
    scoreTown,
    scoreHours,
    scoreHousing,
    scoreSecondJobFeasibility,
    scoreOvertimeAvailability,
    createdAt,
    updatedAt,
  ]);
}
