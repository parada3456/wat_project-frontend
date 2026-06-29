import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_job_model.dart';

part 'user_job_entity.g.dart';

@JsonSerializable()
class UserJobEntity {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'assigned_at')
  final String assignedAt;
  @JsonKey(name: 'is_main')
  final bool isMain;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;

  UserJobEntity({
    required this.userId,
    required this.jobId,
    required this.assignedAt,
    required this.isMain,
    this.startDate,
    this.endDate,
  });

  factory UserJobEntity.fromJson(Map<String, dynamic> json) => _$UserJobEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserJobEntityToJson(this);

  UserJobModel toModel() => UserJobModel(
        userId: userId,
        jobId: jobId,
        assignedAt: DateTime.parse(assignedAt),
        isMain: isMain,
        startDate: startDate != null ? DateTime.parse(startDate!) : null,
        endDate: endDate != null ? DateTime.parse(endDate!) : null,
      );
}
