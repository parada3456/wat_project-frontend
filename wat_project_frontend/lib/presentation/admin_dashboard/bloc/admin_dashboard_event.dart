abstract class AdminDashboardEvent {
  const AdminDashboardEvent();
}

class AdminStatsRequested extends AdminDashboardEvent {
  const AdminStatsRequested();
}

class AdminPendingVerificationsRequested extends AdminDashboardEvent {
  const AdminPendingVerificationsRequested();
}

class AdminVerifyMissionSubmitted extends AdminDashboardEvent {
  final String userMissionId;
  final bool approved;
  final String? reason;

  const AdminVerifyMissionSubmitted({
    required this.userMissionId,
    required this.approved,
    this.reason,
  });
}

class AdminUsersSearchRequested extends AdminDashboardEvent {
  final String search;
  const AdminUsersSearchRequested(this.search);
}

class AdminUserDetailRequested extends AdminDashboardEvent {
  final String userId;
  const AdminUserDetailRequested(this.userId);
}

class AdminAdjustPointsSubmitted extends AdminDashboardEvent {
  final String userId;
  final int pointsDelta;
  final String reason;

  const AdminAdjustPointsSubmitted({
    required this.userId,
    required this.pointsDelta,
    required this.reason,
  });
}
