import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_dashboard_event.freezed.dart';

@freezed
class AdminDashboardEvent with _$AdminDashboardEvent {
  const factory AdminDashboardEvent.statsRequested() = AdminStatsRequested;
  const factory AdminDashboardEvent.pendingVerificationsRequested() =
      AdminPendingVerificationsRequested;
  const factory AdminDashboardEvent.verifyMissionSubmitted({
    required String userMissionId,
    required bool approved,
    String? reason,
  }) = AdminVerifyMissionSubmitted;
  const factory AdminDashboardEvent.usersSearchRequested(String search) =
      AdminUsersSearchRequested;
  const factory AdminDashboardEvent.userDetailRequested(String userId) =
      AdminUserDetailRequested;
  const factory AdminDashboardEvent.adjustPointsSubmitted({
    required String userId,
    required int pointsDelta,
    required String reason,
  }) = AdminAdjustPointsSubmitted;
}
