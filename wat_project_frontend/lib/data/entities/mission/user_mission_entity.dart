import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';

part 'user_mission_entity.g.dart';

@JsonSerializable()
class UserMissionEntity {
  @JsonKey(name: 'UserMissionID')
  final String userMissionId;
  @JsonKey(name: 'UserID')
  final String userId;
  @JsonKey(name: 'MissionID')
  final String missionId;
  @JsonKey(name: 'Status')
  final UserMissionStatus status;
  @JsonKey(name: 'CalculatedDueDate')
  final DateTime? calculatedDueDate;
  @JsonKey(name: 'ProofURL')
  final String? proofUrl;
  @JsonKey(name: 'ProofSubmittedAt')
  final DateTime? proofSubmittedAt;
  @JsonKey(name: 'VerifiedAt')
  final DateTime? verifiedAt;
  @JsonKey(name: 'VerifiedBy')
  final String? verifiedBy;
  @JsonKey(name: 'BasePointsEarned')
  final int basePointsEarned;
  @JsonKey(name: 'SpeedBonusPoints')
  final int speedBonusPoints;
  @JsonKey(name: 'StreakBonusPoints')
  final int streakBonusPoints;
  @JsonKey(name: 'FirstCompleterBonusPoints')
  final int firstCompleterBonusPoints;
  @JsonKey(name: 'TotalPointsEarned')
  final int totalPointsEarned;
  @JsonKey(name: 'RewardedAt')
  final DateTime? rewardedAt;
  @JsonKey(name: 'CreatedAt')
  final DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
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
