import 'package:json_annotation/json_annotation.dart';

part 'job_housing_model.g.dart';

@JsonSerializable()
class JobHousingModel {
  final String housingId;
  final String jobId;
  final String? description;
  final double weeklyRate;
  final double deposit;
  final String? transportation;
  final DateTime? rangeMinStartDate;
  final DateTime? rangeMaxStartDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const JobHousingModel({
    required this.housingId,
    required this.jobId,
    this.description,
    this.weeklyRate = 0.0,
    this.deposit = 0.0,
    this.transportation,
    this.rangeMinStartDate,
    this.rangeMaxStartDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobHousingModel.fromJson(Map<String, dynamic> json) =>
      _$JobHousingModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobHousingModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobHousingModel &&
          runtimeType == other.runtimeType &&
          housingId == other.housingId &&
          jobId == other.jobId &&
          description == other.description &&
          weeklyRate == other.weeklyRate &&
          deposit == other.deposit &&
          transportation == other.transportation &&
          rangeMinStartDate == other.rangeMinStartDate &&
          rangeMaxStartDate == other.rangeMaxStartDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    housingId,
    jobId,
    description,
    weeklyRate,
    deposit,
    transportation,
    rangeMinStartDate,
    rangeMaxStartDate,
    createdAt,
    updatedAt,
  );
}
