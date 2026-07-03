import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/mission_model.dart';

part 'mission_entity.g.dart';

@JsonSerializable()
class MissionEntity {
  @JsonKey(name: 'MissionId')
  final String missionId;
  @JsonKey(name: 'PhaseId')
  final String phaseId;
  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Description')
  final String? description;
  final String? location;
  @JsonKey(name: 'BasePoints')
  final int basePoints;
  @JsonKey(name: 'IsMandatory')
  final bool isMandatory;
  @JsonKey(name: 'VerificationType')
  final VerificationType verificationType;
  @JsonKey(name: 'DueDateType')
  final String? dueDateType;
  @JsonKey(name: 'FixedDueDate')
  final DateTime? fixedDueDate;
  @JsonKey(name: 'RelativeTriggerEvent')
  final String? relativeTriggerEvent;
  @JsonKey(name: 'RelativeDaysOffset')
  final int? relativeDaysOffset;
  @JsonKey(name: 'CreatedAt')
  final DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
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
    this.dueDateType,
    this.fixedDueDate,
    this.relativeTriggerEvent,
    this.relativeDaysOffset,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MissionEntity.fromJson(Map<String, dynamic> json) => _$MissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionEntityToJson(this);

  MissionModel toModel() => MissionModel(
        missionId: missionId,
        phaseId: phaseId,
        title: title,
        description: description,
        location: location,
        basePoints: basePoints,
        isMandatory: isMandatory,
        verificationType: verificationType,
        dueDateType: dueDateType,
        fixedDueDate: fixedDueDate,
        relativeTriggerEvent: relativeTriggerEvent,
        relativeDaysOffset: relativeDaysOffset,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
