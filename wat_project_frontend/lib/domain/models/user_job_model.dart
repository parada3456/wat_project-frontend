class UserJobModel {
  final String userId;
  final String jobId;
  final DateTime assignedAt;
  final bool isMain;
  final DateTime? startDate;
  final DateTime? endDate;

  const UserJobModel({
    required this.userId,
    required this.jobId,
    required this.assignedAt,
    required this.isMain,
    this.startDate,
    this.endDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserJobModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          jobId == other.jobId &&
          assignedAt == other.assignedAt &&
          isMain == other.isMain &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode => Object.hash(
        userId,
        jobId,
        assignedAt,
        isMain,
        startDate,
        endDate,
      );
}
