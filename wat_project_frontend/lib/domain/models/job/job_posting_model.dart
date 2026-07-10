import 'package:json_annotation/json_annotation.dart';

part 'job_posting_model.g.dart';

@JsonSerializable()
class JobPostingModel {
  final String jobId;
  final String? agencyName;
  final String? employerTitle;
  final String? position;
  final String? positionType;
  final String? locationCity;
  final String? locationState;
  final String? groupLocation;
  final bool usSponsor;
  final double salaryRangeMin;
  final double salaryRangeMax;
  final int availableSlots;
  final String? description;
  final String? sourceUrl;
  final DateTime? scrapeAt;
  final DateTime? postedAt;
  final DateTime updatedAt;

  const JobPostingModel({
    required this.jobId,
    this.agencyName,
    this.employerTitle,
    this.position,
    this.positionType,
    this.locationCity,
    this.locationState,
    this.groupLocation,
    this.usSponsor = false,
    this.salaryRangeMin = 0.0,
    this.salaryRangeMax = 0.0,
    this.availableSlots = 0,
    this.description,
    this.sourceUrl,
    this.scrapeAt,
    this.postedAt,
    required this.updatedAt,
  });

  factory JobPostingModel.fromJson(Map<String, dynamic> json) =>
      _$JobPostingModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostingModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobPostingModel &&
          runtimeType == other.runtimeType &&
          jobId == other.jobId &&
          agencyName == other.agencyName &&
          employerTitle == other.employerTitle &&
          position == other.position &&
          positionType == other.positionType &&
          locationCity == other.locationCity &&
          locationState == other.locationState &&
          groupLocation == other.groupLocation &&
          usSponsor == other.usSponsor &&
          salaryRangeMin == other.salaryRangeMin &&
          salaryRangeMax == other.salaryRangeMax &&
          availableSlots == other.availableSlots &&
          description == other.description &&
          sourceUrl == other.sourceUrl &&
          scrapeAt == other.scrapeAt &&
          postedAt == other.postedAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hashAll([
    jobId,
    agencyName,
    employerTitle,
    position,
    positionType,
    locationCity,
    locationState,
    groupLocation,
    usSponsor,
    salaryRangeMin,
    salaryRangeMax,
    availableSlots,
    description,
    sourceUrl,
    scrapeAt,
    postedAt,
    updatedAt,
  ]);
}
