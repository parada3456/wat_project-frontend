import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';

part 'review_score_model.g.dart';

@JsonSerializable()
class ReviewScoreModel {
  final double agency;
  final double job;
  final double coworkers;
  final double town;
  final double hours;
  final double housing;
  @JsonKey(name: 'second_job_feasibility')
  final double secondJobFeasibility;
  @JsonKey(name: 'overtime_availability')
  final double overtimeAvailability;

  ReviewScoreModel({
    required this.agency,
    required this.job,
    required this.coworkers,
    required this.town,
    required this.hours,
    required this.housing,
    required this.secondJobFeasibility,
    required this.overtimeAvailability,
  });

  factory ReviewScoreModel.fromJson(Map<String, dynamic> json) => _$ReviewScoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewScoreModelToJson(this);
}
