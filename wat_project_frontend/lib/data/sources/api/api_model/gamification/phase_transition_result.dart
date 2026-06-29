import 'package:json_annotation/json_annotation.dart';

part 'phase_transition_result.g.dart';

@JsonSerializable()
class PhaseTransitionResult {
  final bool transitioned;
  @JsonKey(name: 'previousPhaseId')
  final String? previousPhaseId;
  @JsonKey(name: 'newPhaseId')
  final String? newPhaseId;
  @JsonKey(name: 'pointsRewarded')
  final int? pointsRewarded;
  @JsonKey(name: 'completedAt')
  final String? completedAt;

  PhaseTransitionResult({
    required this.transitioned,
    this.previousPhaseId,
    this.newPhaseId,
    this.pointsRewarded,
    this.completedAt,
  });

  factory PhaseTransitionResult.fromJson(Map<String, dynamic> json) =>
      _$PhaseTransitionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PhaseTransitionResultToJson(this);
}
