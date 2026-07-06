import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';

part 'user_phase_history_entity.g.dart';

@JsonSerializable()
class UserPhaseHistoryEntity {
  @JsonKey(name: 'history_id')
  final String historyId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'phase_id')
  final String phaseId;
  @JsonKey(name: 'phase_points_earned')
  final int phasePointsEarned;
  @JsonKey(name: 'entered_at')
  final DateTime enteredAt;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  UserPhaseHistoryEntity({
    required this.historyId,
    required this.userId,
    required this.phaseId,
    required this.phasePointsEarned,
    required this.enteredAt,
    this.completedAt,
  });

  factory UserPhaseHistoryEntity.fromJson(Map<String, dynamic> json) => _$UserPhaseHistoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserPhaseHistoryEntityToJson(this);

  UserPhaseHistoryModel toModel() => UserPhaseHistoryModel(
        historyId: historyId,
        userId: userId,
        phaseId: phaseId,
        phasePointsEarned: phasePointsEarned,
        enteredAt: enteredAt,
        completedAt: completedAt,
      );
}
