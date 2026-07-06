class AdminStatsModel {
  final int totalUsers;
  final int activeUsers;
  final int pendingVerifications;
  final int activeJobs;
  final int averageCreditScore;
  final int totalPointsAwarded;

  const AdminStatsModel({
    required this.totalUsers,
    required this.activeUsers,
    required this.pendingVerifications,
    required this.activeJobs,
    required this.averageCreditScore,
    required this.totalPointsAwarded,
  });
}
