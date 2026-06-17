enum VerificationType {
  none,
  upload,
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
  final String? dueDateType;
  final DateTime? fixedDueDate;
  final String? relativeTriggerEvent;
  final int? relativeDaysOffset;
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
    this.dueDateType,
    this.fixedDueDate,
    this.relativeTriggerEvent,
    this.relativeDaysOffset,
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
          dueDateType == other.dueDateType &&
          fixedDueDate == other.fixedDueDate &&
          relativeTriggerEvent == other.relativeTriggerEvent &&
          relativeDaysOffset == other.relativeDaysOffset &&
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
        dueDateType,
        fixedDueDate,
        relativeTriggerEvent,
        relativeDaysOffset,
        createdAt,
        updatedAt,
      );
}
