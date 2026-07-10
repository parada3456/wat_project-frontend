import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

// ---------------------------------------------------------------------------
// TaskEntity ↔ TaskModel
// ---------------------------------------------------------------------------

extension TaskEntityMapper on TaskEntity {
  TaskModel toModel() => TaskModel(
    taskId: taskId,
    // missionId: missionId,
    title: title,
    description: description,
    isCompleted: isCompleted,
    completedAt: completedAt,
    // createdAt: createdAt,
    // updatedAt: updatedAt,
  );
}

extension TaskModelMapper on TaskModel {
  TaskEntity toEntity() => TaskEntity(
    taskId: taskId,
    // missionId: missionId,
    title: title,
    description: description,
    isCompleted: isCompleted,
    completedAt: completedAt,
    // createdAt: createdAt,
    // updatedAt: updatedAt,
  );
}

extension TaskEntityListMapper on List<TaskEntity> {
  List<TaskModel> toModelList() => map((e) => e.toModel()).toList();
}

extension TaskModelListMapper on List<TaskModel> {
  List<TaskEntity> toEntityList() => map((e) => e.toEntity()).toList();
}

// ---------------------------------------------------------------------------
// UserTaskEntity ↔ UserTaskModel
// ---------------------------------------------------------------------------

extension UserTaskEntityMapper on UserTaskEntity {
  UserTaskModel toModel() => UserTaskModel(
    userTaskId: userTaskId,
    userId: userId,
    taskId: taskId,
    userMissionId: userMissionId,
    isCompleted: isCompleted,
    completedAt: completedAt,
    updatedAt: updatedAt,
  );
}

extension UserTaskModelMapper on UserTaskModel {
  UserTaskEntity toEntity() => UserTaskEntity(
    userTaskId: userTaskId,
    userId: userId,
    taskId: taskId,
    userMissionId: userMissionId,
    isCompleted: isCompleted,
    completedAt: completedAt,
    updatedAt: updatedAt,
  );
}

extension UserTaskEntityListMapper on List<UserTaskEntity> {
  List<UserTaskModel> toModelList() => map((e) => e.toModel()).toList();
}

extension UserTaskModelListMapper on List<UserTaskModel> {
  List<UserTaskEntity> toEntityList() => map((e) => e.toEntity()).toList();
}

// ---------------------------------------------------------------------------
// UserMissionEntity ↔ UserMissionModel
// ---------------------------------------------------------------------------

extension UserMissionEntityMapper on UserMissionEntity {
  UserMissionModel toModel() => UserMissionModel(
    userMissionId: userMissionId,
    userId: userId,
    missionId: missionId,
    status: status,
    calculatedDueDate: calculatedDueDate,
    proofUrl: proofUrl,
    proofSubmittedAt: proofSubmittedAt,
    verifiedAt: verifiedAt,
    verifiedBy: verifiedBy,
    // basePointsEarned: basePointsEarned,
    // speedBonusPoints: speedBonusPoints,
    // streakBonusPoints: streakBonusPoints,
    // firstCompleterBonusPoints: firstCompleterBonusPoints,
    // totalPointsEarned: totalPointsEarned,
    // rewardedAt: rewardedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension UserMissionModelMapper on UserMissionModel {
  UserMissionEntity toEntity() => UserMissionEntity(
    userMissionId: userMissionId,
    userId: userId,
    missionId: missionId,
    status: status,
    calculatedDueDate: calculatedDueDate,
    proofUrl: proofUrl,
    proofSubmittedAt: proofSubmittedAt,
    verifiedAt: verifiedAt,
    verifiedBy: verifiedBy,
    // basePointsEarned: basePointsEarned,
    // speedBonusPoints: speedBonusPoints,
    // streakBonusPoints: streakBonusPoints,
    // firstCompleterBonusPoints: firstCompleterBonusPoints,
    // totalPointsEarned: totalPointsEarned,
    // rewardedAt: rewardedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

/// Nullable helpers — safe to call when the entity/model might be absent.
extension UserMissionEntityNullableMapper on UserMissionEntity? {
  UserMissionModel? toModelOrNull() => this?.toModel();
}

extension UserMissionModelNullableMapper on UserMissionModel? {
  UserMissionEntity? toEntityOrNull() => this?.toEntity();
}

// ---------------------------------------------------------------------------
// MissionEntity ↔ MissionModel
// ---------------------------------------------------------------------------

extension MissionEntityMapper on MissionEntity {
  MissionModel toModel() => MissionModel(
    missionId: missionId,
    phaseId: phaseId,
    title: title,
    description: description,
    location: location,
    basePoints: basePoints,
    isMandatory: isMandatory,
    verificationType: verificationType,
    userMission: userMission.toModelOrNull(),
    tasks: tasks.toModelList(),
    createdBy: createdBy,
    // dueDateType: dueDateType,
    // fixedDueDate: fixedDueDate,
    // relativeTriggerEvent: relativeTriggerEvent,
    // relativeDaysOffset: relativeDaysOffset,
    isActive: isActive,
    isLocked: isLocked,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension MissionModelMapper on MissionModel {
  MissionEntity toEntity() => MissionEntity(
    missionId: missionId,
    phaseId: phaseId,
    title: title,
    description: description,
    location: location,
    basePoints: basePoints,
    isMandatory: isMandatory,
    verificationType: verificationType,
    userMission: userMission.toEntityOrNull(),
    tasks: tasks.toEntityList(),
    createdBy: createdBy,
    // dueDateType: dueDateType,
    // fixedDueDate: fixedDueDate,
    // relativeTriggerEvent: relativeTriggerEvent,
    // relativeDaysOffset: relativeDaysOffset,
    isActive: isActive,
    isLocked: isLocked,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension MissionEntityListMapper on List<MissionEntity> {
  List<MissionModel> toModelList() => map((e) => e.toModel()).toList();
}

extension MissionModelListMapper on List<MissionModel> {
  List<MissionEntity> toEntityList() => map((e) => e.toEntity()).toList();
}

// ---------------------------------------------------------------------------
// MissionDetailResponse → MissionDetailModel
// ---------------------------------------------------------------------------

extension MissionDetailResponseMapper on MissionDetailResponse {
  MissionDetailModel toModel() => MissionDetailModel(
    mission: mission.toModel(),
    userMission:
        userMission?.toModel() ??
        UserMissionModel(
          userMissionId: '',
          userId: '',
          missionId: mission.missionId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
    tasks: tasks.toModelList(),
    userTasks: userTasks.toModelList(),
  );
}
