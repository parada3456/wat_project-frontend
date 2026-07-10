import 'package:json_annotation/json_annotation.dart';

part 'job_overall_rating_model.g.dart';

@JsonSerializable()
class JobOverallRatingModel {
  final String ratingSummaryId;
  final String jobId;
  final double overallRate;
  final double agencyRate;
  final double jobRate;
  final double coworkersRate;
  final double townRate;
  final double hoursRate;
  final double housingRate;
  final double secondJobFeasibilityRate;
  final double overtimeAvailabilityRate;
  final int reviewCount;
  final DateTime updatedAt;

  const JobOverallRatingModel({
    required this.ratingSummaryId,
    required this.jobId,
    this.overallRate = 0.0,
    this.agencyRate = 0.0,
    this.jobRate = 0.0,
    this.coworkersRate = 0.0,
    this.townRate = 0.0,
    this.hoursRate = 0.0,
    this.housingRate = 0.0,
    this.secondJobFeasibilityRate = 0.0,
    this.overtimeAvailabilityRate = 0.0,
    this.reviewCount = 0,
    required this.updatedAt,
  });

  factory JobOverallRatingModel.fromJson(Map<String, dynamic> json) =>
      _$JobOverallRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobOverallRatingModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobOverallRatingModel &&
          runtimeType == other.runtimeType &&
          ratingSummaryId == other.ratingSummaryId &&
          jobId == other.jobId &&
          overallRate == other.overallRate &&
          agencyRate == other.agencyRate &&
          jobRate == other.jobRate &&
          coworkersRate == other.coworkersRate &&
          townRate == other.townRate &&
          hoursRate == other.hoursRate &&
          housingRate == other.housingRate &&
          secondJobFeasibilityRate == other.secondJobFeasibilityRate &&
          overtimeAvailabilityRate == other.overtimeAvailabilityRate &&
          reviewCount == other.reviewCount &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    ratingSummaryId,
    jobId,
    overallRate,
    agencyRate,
    jobRate,
    coworkersRate,
    townRate,
    hoursRate,
    housingRate,
    secondJobFeasibilityRate,
    overtimeAvailabilityRate,
    reviewCount,
    updatedAt,
  );
}
