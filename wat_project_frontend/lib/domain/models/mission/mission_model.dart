import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

enum VerificationType {
  @JsonValue('none')
  none,
  @JsonValue('upload')
  upload,
  @JsonValue('admin')
  admin,
}

class MissionModel {
  final String missionId;
  final String phaseId;
  final String title;
  final String? description;
  final String? location;
  final int basePoints;
  final bool isMandatory;
  final VerificationType verificationType;
  final UserMissionModel? userMission;
  final List<TaskModel> tasks;
  // final String? dueDateType;
  // final DateTime? fixedDueDate;
  // final String? relativeTriggerEvent;
  // final int? relativeDaysOffset;
  final bool isActive;
  final bool isLocked;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MissionModel({
    required this.missionId,
    required this.phaseId,
    required this.title,
    this.description,
    this.location,
    this.basePoints = 0,
    this.isMandatory = false,
    this.verificationType = VerificationType.none,
    this.userMission,
    required this.tasks,
    // this.dueDateType,
    // this.fixedDueDate,
    // this.relativeTriggerEvent,
    // this.relativeDaysOffset,
    required this.isActive,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionModel &&
          runtimeType == other.runtimeType &&
          missionId == other.missionId &&
          phaseId == other.phaseId &&
          title == other.title &&
          description == other.description &&
          location == other.location &&
          basePoints == other.basePoints &&
          isMandatory == other.isMandatory &&
          verificationType == other.verificationType &&
          // dueDateType == other.dueDateType &&
          // fixedDueDate == other.fixedDueDate &&
          // relativeTriggerEvent == other.relativeTriggerEvent &&
          // relativeDaysOffset == other.relativeDaysOffset &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        missionId,
        phaseId,
        title,
        description,
        location,
        basePoints,
        isMandatory,
        verificationType,
        userMission,
        tasks,
        // dueDateType,
        // fixedDueDate,
        // relativeTriggerEvent,
        // relativeDaysOffset,
        isActive,
        isLocked,
        createdAt,
        updatedAt,
      );
}
