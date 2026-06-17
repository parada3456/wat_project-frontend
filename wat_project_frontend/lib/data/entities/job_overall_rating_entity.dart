import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/job_overall_rating_model.dart';

part 'job_overall_rating_entity.g.dart';

@JsonSerializable()
class JobOverallRatingEntity {
  @JsonKey(name: 'rating_summary_id')
  final String ratingSummaryId;
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'overall_rate')
  final double overallRate;
  @JsonKey(name: 'agency_rate')
  final double agencyRate;
  @JsonKey(name: 'job_rate')
  final double jobRate;
  @JsonKey(name: 'coworkers_rate')
  final double coworkersRate;
  @JsonKey(name: 'town_rate')
  final double townRate;
  @JsonKey(name: 'hours_rate')
  final double hoursRate;
  @JsonKey(name: 'housing_rate')
  final double housingRate;
  @JsonKey(name: 'second_job_feasibility_rate')
  final double secondJobFeasibilityRate;
  @JsonKey(name: 'overtime_availability_rate')
  final double overtimeAvailabilityRate;
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  JobOverallRatingEntity({
    required this.ratingSummaryId,
    required this.jobId,
    required this.overallRate,
    required this.agencyRate,
    required this.jobRate,
    required this.coworkersRate,
    required this.townRate,
    required this.hoursRate,
    required this.housingRate,
    required this.secondJobFeasibilityRate,
    required this.overtimeAvailabilityRate,
    required this.reviewCount,
    required this.updatedAt,
  });

  factory JobOverallRatingEntity.fromJson(Map<String, dynamic> json) =>
      _$JobOverallRatingEntityFromJson(json);

  JobOverallRatingModel toModel() => JobOverallRatingModel(
        ratingSummaryId: ratingSummaryId,
        jobId: jobId,
        overallRate: overallRate,
        agencyRate: agencyRate,
        jobRate: jobRate,
        coworkersRate: coworkersRate,
        townRate: townRate,
        hoursRate: hoursRate,
        housingRate: housingRate,
        secondJobFeasibilityRate: secondJobFeasibilityRate,
        overtimeAvailabilityRate: overtimeAvailabilityRate,
        reviewCount: reviewCount,
        updatedAt: DateTime.parse(updatedAt),
      );
}
