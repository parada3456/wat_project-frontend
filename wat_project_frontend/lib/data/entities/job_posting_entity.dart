import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/job_posting_model.dart';

part 'job_posting_entity.g.dart';

@JsonSerializable()
class JobPostingEntity {
  @JsonKey(name: 'job_id')
  final String jobId;
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
  final bool usSponsor;
  @JsonKey(name: 'salary_range_min')
  final double salaryRangeMin;
  @JsonKey(name: 'salary_range_max')
  final double salaryRangeMax;
  @JsonKey(name: 'available_slots')
  final int availableSlots;
  final String? description;
  @JsonKey(name: 'source_url')
  final String? sourceUrl;
  @JsonKey(name: 'scrape_at')
  final String? scrapeAt;
  @JsonKey(name: 'posted_at')
  final String? postedAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  JobPostingEntity({
    required this.jobId,
    this.agencyName,
    this.employerTitle,
    this.position,
    this.positionType,
    this.locationCity,
    this.locationState,
    this.groupLocation,
    required this.usSponsor,
    required this.salaryRangeMin,
    required this.salaryRangeMax,
    required this.availableSlots,
    this.description,
    this.sourceUrl,
    this.scrapeAt,
    this.postedAt,
    required this.updatedAt,
  });

  factory JobPostingEntity.fromJson(Map<String, dynamic> json) =>
      _$JobPostingEntityFromJson(json);

  JobPostingModel toModel() => JobPostingModel(
        jobId: jobId,
        agencyName: agencyName,
        employerTitle: employerTitle,
        position: position,
        positionType: positionType,
        locationCity: locationCity,
        locationState: locationState,
        groupLocation: groupLocation,
        usSponsor: usSponsor,
        salaryRangeMin: salaryRangeMin,
        salaryRangeMax: salaryRangeMax,
        availableSlots: availableSlots,
        description: description,
        sourceUrl: sourceUrl,
        scrapeAt: scrapeAt != null ? DateTime.parse(scrapeAt!) : null,
        postedAt: postedAt != null ? DateTime.parse(postedAt!) : null,
        updatedAt: DateTime.parse(updatedAt),
      );
}
