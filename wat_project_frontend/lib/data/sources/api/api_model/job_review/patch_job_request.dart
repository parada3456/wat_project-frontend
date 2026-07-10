import 'package:json_annotation/json_annotation.dart';

part 'patch_job_request.g.dart';

@JsonSerializable()
class PatchJobRequest {
  @JsonKey(name: 'job_id')
  final String? jobId;
  @JsonKey(name: 'agency_name')
  final String? agencyName;
  @JsonKey(name: 'employer_title')
  final String? employerTitle;
  final String? position;
  @JsonKey(name: 'position_type')
  final String? positionType;
  @JsonKey(name: 'location_city')
  final String? locationCity;
  @JsonKey(name: 'location_state')
  final String? locationState;
  @JsonKey(name: 'group_location')
  final String? groupLocation;
  @JsonKey(name: 'us_sponsor')
  final bool? usSponsor;
  @JsonKey(name: 'salary_range_min')
  final double? salaryRangeMin;
  @JsonKey(name: 'salary_range_max')
  final double? salaryRangeMax;
  @JsonKey(name: 'available_slots')
  final int? availableSlots;
  final String? description;
  @JsonKey(name: 'source_url')
  final String? sourceUrl;
  @JsonKey(name: 'scrape_at')
  final String? scrapeAt;
  @JsonKey(name: 'posted_at')
  final String? postedAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  PatchJobRequest({
    this.jobId,
    this.agencyName,
    this.employerTitle,
    this.position,
    this.positionType,
    this.locationCity,
    this.locationState,
    this.groupLocation,
    this.usSponsor,
    this.salaryRangeMin,
    this.salaryRangeMax,
    this.availableSlots,
    this.description,
    this.sourceUrl,
    this.scrapeAt,
    this.postedAt,
    this.updatedAt,
  });

  factory PatchJobRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchJobRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchJobRequestToJson(this);
}
