import 'package:json_annotation/json_annotation.dart';

part 'assign_job_request.g.dart';

@JsonSerializable()
class AssignJobRequest {
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'is_main')
  final bool isMain;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;

  AssignJobRequest({
    required this.jobId,
    required this.isMain,
    this.startDate,
    this.endDate,
  });

  factory AssignJobRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignJobRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AssignJobRequestToJson(this);
}
