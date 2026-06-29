import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_housing_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_overall_rating_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';

part 'job_detail_response.g.dart';

@JsonSerializable()
class JobDetailResponse {
  final JobPostingEntity job;
  final List<JobHousingEntity> housing;
  final JobOverallRatingEntity? rating;

  JobDetailResponse({
    required this.job,
    required this.housing,
    this.rating,
  });

  factory JobDetailResponse.fromJson(Map<String, dynamic> json) => _$JobDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JobDetailResponseToJson(this);
}
