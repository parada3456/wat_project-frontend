import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/job_housing_model.dart';

part 'job_housing_entity.g.dart';

@JsonSerializable()
class JobHousingEntity {
  @JsonKey(name: 'housing_id')
  final String housingId;
  @JsonKey(name: 'job_id')
  final String jobId;
  final String? description;
  @JsonKey(name: 'weekly_rate')
  final double weeklyRate;
  final double deposit;
  final String? transportation;
  @JsonKey(name: 'range_min_start_date')
  final String? rangeMinStartDate;
  @JsonKey(name: 'range_max_start_date')
  final String? rangeMaxStartDate;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  JobHousingEntity({
    required this.housingId,
    required this.jobId,
    this.description,
    required this.weeklyRate,
    required this.deposit,
    this.transportation,
    this.rangeMinStartDate,
    this.rangeMaxStartDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobHousingEntity.fromJson(Map<String, dynamic> json) =>
      _$JobHousingEntityFromJson(json);

  JobHousingModel toModel() => JobHousingModel(
        housingId: housingId,
        jobId: jobId,
        description: description,
        weeklyRate: weeklyRate,
        deposit: deposit,
        transportation: transportation,
        rangeMinStartDate:
            rangeMinStartDate != null ? DateTime.parse(rangeMinStartDate!) : null,
        rangeMaxStartDate:
            rangeMaxStartDate != null ? DateTime.parse(rangeMaxStartDate!) : null,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );
}
