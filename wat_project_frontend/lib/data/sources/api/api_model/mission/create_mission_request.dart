import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_task_request.dart';

part 'create_mission_request.g.dart';

@JsonSerializable()
class CreateMissionRequest {
  @JsonKey(name: 'phase_id')
  final String phaseId;
  final String title;
  final String? description;
  final String? location;
  @JsonKey(name: 'base_points')
  final int basePoints;
  @JsonKey(name: 'is_mandatory')
  final bool isMandatory;
  @JsonKey(name: 'verification_type')
  final String verificationType;
  @JsonKey(name: 'due_date_type')
  final String? dueDateType;
  @JsonKey(name: 'fixed_due_date')
  final String? fixedDueDate;
  @JsonKey(name: 'relative_trigger_event')
  final String? relativeTriggerEvent;
  @JsonKey(name: 'relative_days_offset')
  final int? relativeDaysOffset;
  final List<CreateTaskRequest> taskList;

  CreateMissionRequest({
    required this.phaseId,
    required this.title,
    this.description,
    this.location,
    required this.basePoints,
    required this.isMandatory,
    required this.verificationType,
    this.dueDateType,
    this.fixedDueDate,
    this.relativeTriggerEvent,
    this.relativeDaysOffset,
    required this.taskList,
  });

  factory CreateMissionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateMissionRequestToJson(this);
}
