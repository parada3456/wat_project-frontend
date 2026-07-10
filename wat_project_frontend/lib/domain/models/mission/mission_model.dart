import 'package:equatable/equatable.dart';
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

class MissionModel extends Equatable {
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
  final String? createdBy;
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
    this.createdBy,
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
  List<Object?> get props => [
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
    createdBy,
    // dueDateType,
    // fixedDueDate,
    // relativeTriggerEvent,
    // relativeDaysOffset,
    isActive,
    isLocked,
    createdAt,
    updatedAt,
  ];
}
