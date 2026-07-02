import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';

part 'journey_phase_entity.g.dart';

@JsonSerializable()
class JourneyPhaseEntity {
  @JsonKey(name: 'PhaseId')
  final String phaseId;
  @JsonKey(name: 'PhaseNumber')
  final int phaseNumber;
  @JsonKey(name: 'title')
  final String title;
  final String? description;
  @JsonKey(name: 'CreatedAt')
  final DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
  final DateTime updatedAt;

  JourneyPhaseEntity({
    required this.phaseId,
    required this.phaseNumber,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JourneyPhaseEntity.fromJson(Map<String, dynamic> json) => _$JourneyPhaseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyPhaseEntityToJson(this);

  JourneyPhaseModel toModel() => JourneyPhaseModel(
        phaseId: phaseId,
        phaseNumber: phaseNumber,
        title: title,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
