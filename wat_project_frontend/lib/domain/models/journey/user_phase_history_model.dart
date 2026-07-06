class UserPhaseHistoryModel {
  final String historyId;
  final String userId;
  final String phaseId;
  final int phasePointsEarned;
  final DateTime enteredAt;
  final DateTime? completedAt;

  const UserPhaseHistoryModel({
    required this.historyId,
    required this.userId,
    required this.phaseId,
    this.phasePointsEarned = 0,
    required this.enteredAt,
    this.completedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPhaseHistoryModel &&
          runtimeType == other.runtimeType &&
          historyId == other.historyId &&
          userId == other.userId &&
          phaseId == other.phaseId &&
          phasePointsEarned == other.phasePointsEarned &&
          enteredAt == other.enteredAt &&
          completedAt == other.completedAt;

  @override
  int get hashCode => Object.hash(
        historyId,
        userId,
        phaseId,
        phasePointsEarned,
        enteredAt,
        completedAt,
      );
}
