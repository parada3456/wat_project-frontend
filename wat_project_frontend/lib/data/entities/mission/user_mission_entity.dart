import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';

part 'user_mission_entity.g.dart';

@JsonSerializable()
class UserMissionEntity {
  @JsonKey(name: 'user_mission_id')
  final String userMissionId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'mission_id')
  final String missionId;
  final UserMissionStatus status;
  @JsonKey(name: 'calculated_due_date')
  final DateTime? calculatedDueDate;
  @JsonKey(name: 'proof_url')
  final String? proofUrl;
  @JsonKey(name: 'proof_submitted_at')
  final DateTime? proofSubmittedAt;
  @JsonKey(name: 'verified_at')
  final DateTime? verifiedAt;
  @JsonKey(name: 'verified_by')
  final String? verifiedBy;
  @JsonKey(name: 'base_points_earned')
  final int basePointsEarned;
  @JsonKey(name: 'speed_bonus_points')
  final int speedBonusPoints;
  @JsonKey(name: 'streak_bonus_points')
  final int streakBonusPoints;
  @JsonKey(name: 'first_completer_bonus_points')
  final int firstCompleterBonusPoints;
  @JsonKey(name: 'total_points_earned')
  final int totalPointsEarned;
  @JsonKey(name: 'rewarded_at')
  final DateTime? rewardedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserMissionEntity({
    required this.userMissionId,
    required this.userId,
    required this.missionId,
    required this.status,
    this.calculatedDueDate,
    this.proofUrl,
    this.proofSubmittedAt,
    this.verifiedAt,
    this.verifiedBy,
    required this.basePointsEarned,
    required this.speedBonusPoints,
    required this.streakBonusPoints,
    required this.firstCompleterBonusPoints,
    required this.totalPointsEarned,
    this.rewardedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserMissionEntity.fromJson(Map<String, dynamic> json) => _$UserMissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserMissionEntityToJson(this);

  UserMissionModel toModel() => UserMissionModel(
        userMissionId: userMissionId,
        userId: userId,
        missionId: missionId,
        status: status,
        calculatedDueDate: calculatedDueDate,
        proofUrl: proofUrl,
        proofSubmittedAt:
            proofSubmittedAt,
        verifiedAt: verifiedAt,
        verifiedBy: verifiedBy,
        basePointsEarned: basePointsEarned,
        speedBonusPoints: speedBonusPoints,
        streakBonusPoints: streakBonusPoints,
        firstCompleterBonusPoints: firstCompleterBonusPoints,
        totalPointsEarned: totalPointsEarned,
        rewardedAt: rewardedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
