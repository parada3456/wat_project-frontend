import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_job_model.dart';

part 'assigned_job_entity.g.dart';

@JsonSerializable()
class AssignedJobEntity {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'assigned_at')
  final DateTime assignedAt;
  @JsonKey(name: 'is_main')
  final bool isMain;
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;

  AssignedJobEntity({
    required this.userId,
    required this.jobId,
    required this.assignedAt,
    required this.isMain,
    this.startDate,
    this.endDate,
  });

  factory AssignedJobEntity.fromJson(Map<String, dynamic> json) => _$AssignedJobEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AssignedJobEntityToJson(this);

  UserJobModel toModel() => UserJobModel(
        userId: userId,
        jobId: jobId,
        assignedAt: assignedAt,
        isMain: isMain,
        startDate: startDate,
        endDate: endDate,
      );
}
