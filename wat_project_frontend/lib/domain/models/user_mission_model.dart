enum UserMissionStatus {
  notStarted,
  inProgress,
  pendingVerification,
  completed,
  overdue,
}

class UserMissionModel {
  final String userMissionId;
  final String userId;
  final String missionId;
  final UserMissionStatus status;
  final DateTime? calculatedDueDate;
  final String? proofUrl;
  final DateTime? proofSubmittedAt;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final int basePointsEarned;
  final int speedBonusPoints;
  final int streakBonusPoints;
  final int firstCompleterBonusPoints;
  final int totalPointsEarned;
  final DateTime? rewardedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserMissionModel({
    required this.userMissionId,
    required this.userId,
    required this.missionId,
    this.status = UserMissionStatus.notStarted,
    this.calculatedDueDate,
    this.proofUrl,
    this.proofSubmittedAt,
    this.verifiedAt,
    this.verifiedBy,
    this.basePointsEarned = 0,
    this.speedBonusPoints = 0,
    this.streakBonusPoints = 0,
    this.firstCompleterBonusPoints = 0,
    this.totalPointsEarned = 0,
    this.rewardedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserMissionModel &&
          runtimeType == other.runtimeType &&
          userMissionId == other.userMissionId &&
          userId == other.userId &&
          missionId == other.missionId &&
          status == other.status &&
          calculatedDueDate == other.calculatedDueDate &&
          proofUrl == other.proofUrl &&
          proofSubmittedAt == other.proofSubmittedAt &&
          verifiedAt == other.verifiedAt &&
          verifiedBy == other.verifiedBy &&
          basePointsEarned == other.basePointsEarned &&
          speedBonusPoints == other.speedBonusPoints &&
          streakBonusPoints == other.streakBonusPoints &&
          firstCompleterBonusPoints == other.firstCompleterBonusPoints &&
          totalPointsEarned == other.totalPointsEarned &&
          rewardedAt == other.rewardedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        userMissionId,
        userId,
        missionId,
        status,
        calculatedDueDate,
        proofUrl,
        proofSubmittedAt,
        verifiedAt,
        verifiedBy,
        basePointsEarned,
        speedBonusPoints,
        streakBonusPoints,
        firstCompleterBonusPoints,
        totalPointsEarned,
        rewardedAt,
        createdAt,
        updatedAt,
      );
}
