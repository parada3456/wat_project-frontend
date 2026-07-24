import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/admin_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'admin_dashboard_state.freezed.dart';

@freezed
class AdminDashboardState with _$AdminDashboardState {
  const factory AdminDashboardState.initial() = AdminDashboardInitial;
  const factory AdminDashboardState.loading() = AdminDashboardLoading;
  const factory AdminDashboardState.statsSuccess(AdminStatsModel stats) =
      AdminDashboardStatsSuccess;
  const factory AdminDashboardState.pendingVerificationsSuccess(
    List<UserMissionModel> verifications,
  ) = AdminDashboardPendingVerificationsSuccess;
  const factory AdminDashboardState.usersSuccess(List<UserModel> users) =
      AdminDashboardUsersSuccess;
  const factory AdminDashboardState.userDetailSuccess(UserModel user) =
      AdminDashboardUserDetailSuccess;
  const factory AdminDashboardState.verifySuccess(
    UserMissionModel userMission,
  ) = AdminDashboardVerifySuccess;
  const factory AdminDashboardState.adjustPointsSuccess(
    PointsAdjustmentResultModel result,
  ) = AdminDashboardAdjustPointsSuccess;
  const factory AdminDashboardState.failure(String message) =
      AdminDashboardFailure;
}
