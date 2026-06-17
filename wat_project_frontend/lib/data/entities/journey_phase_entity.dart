import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';

part 'journey_phase_entity.g.dart';

@JsonSerializable()
class JourneyPhaseEntity {
  @JsonKey(name: 'phase_id')
  final String phaseId;
  @JsonKey(name: 'phase_number')
  final int phaseNumber;
  final String title;
  final String? description;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  JourneyPhaseEntity({
    required this.phaseId,
    required this.phaseNumber,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JourneyPhaseEntity.fromJson(Map<String, dynamic> json) =>
      _$JourneyPhaseEntityFromJson(json);

  JourneyPhaseModel toModel() => JourneyPhaseModel(
        phaseId: phaseId,
        phaseNumber: phaseNumber,
        title: title,
        description: description,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );
}
