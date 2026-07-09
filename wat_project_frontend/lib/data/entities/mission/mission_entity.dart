import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

part 'mission_entity.g.dart';

@JsonSerializable()
class MissionEntity {
  @JsonKey(name: 'mission_id')
  final String missionId;
  @JsonKey(name: 'phase_id')
  final String phaseId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String? description;
  final String? location;
  @JsonKey(name: 'base_points')
  final int basePoints;
  @JsonKey(name: 'is_mandatory')
  final bool isMandatory;
  @JsonKey(name: 'verification_type')
  final VerificationType verificationType;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_locked')
  final bool isLocked;
  // @JsonKey(name: 'due_date_type')
  // final String? dueDateType;
  // @JsonKey(name: 'fixed_due_date')
  // final DateTime? fixedDueDate;
  // @JsonKey(name: 'relative_trigger_event')
  // final String? relativeTriggerEvent;
  // @JsonKey(name: 'relative_days_offset')
  // final int? relativeDaysOffset;
  @JsonKey(name: 'user_mission')
  final UserMissionEntity? userMission;
  @JsonKey(name: 'tasks', defaultValue: [])
  final List<TaskEntity> tasks;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  MissionEntity({
    required this.missionId,
    required this.phaseId,
    required this.title,
    this.description,
    this.location,
    required this.basePoints,
    required this.isMandatory,
    required this.verificationType,
    // this.dueDateType,
    // this.fixedDueDate,
    // this.relativeTriggerEvent,
    // this.relativeDaysOffset,
    this.userMission,
    required this.tasks,
    required this.isActive,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MissionEntity.fromJson(Map<String, dynamic> json) => _$MissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionEntityToJson(this);

  // MissionModel toModel() => MissionModel(
  //   missionId: missionId,
  //   phaseId: phaseId,
  //   title: title,
  //   description: description,
  //   location: location,
  //   basePoints: basePoints,
  //   isMandatory: isMandatory,
  //   verificationType: verificationType,
  //   userMission: UserMissionEntity.toModelNullable(userMission),
  //   tasks: tasks.map((task) => task.toModel()).toList(),
  //   // dueDateType: dueDateType,
  //   // fixedDueDate: fixedDueDate,
  //   // relativeTriggerEvent: relativeTriggerEvent,
  //   // relativeDaysOffset: relativeDaysOffset,
  //   isActive: isActive,
  //   isLocked: isLocked,
  //   createdAt: createdAt,
  //   updatedAt: updatedAt,
  // );
}
