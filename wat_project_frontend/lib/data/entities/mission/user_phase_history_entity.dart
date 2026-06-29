import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_phase_history_model.dart';

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
  final String enteredAt;
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  UserPhaseHistoryEntity({
    required this.historyId,
    required this.userId,
    required this.phaseId,
    required this.phasePointsEarned,
    required this.enteredAt,
    this.completedAt,
  });

  factory UserPhaseHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$UserPhaseHistoryEntityFromJson(json);

  UserPhaseHistoryModel toModel() => UserPhaseHistoryModel(
        historyId: historyId,
        userId: userId,
        phaseId: phaseId,
        phasePointsEarned: phasePointsEarned,
        enteredAt: DateTime.parse(enteredAt),
        completedAt: completedAt != null ? DateTime.parse(completedAt!) : null,
      );
}
