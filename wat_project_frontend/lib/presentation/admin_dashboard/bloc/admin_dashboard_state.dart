import 'package:wat_project_frontend/domain/models/admin_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/admin_models.dart';

abstract class AdminDashboardState {
  const AdminDashboardState();
}

class AdminDashboardInitial extends AdminDashboardState {
  const AdminDashboardInitial();
}

class AdminDashboardLoading extends AdminDashboardState {
  const AdminDashboardLoading();
}

class AdminDashboardStatsSuccess extends AdminDashboardState {
  final AdminStatsModel stats;
  const AdminDashboardStatsSuccess(this.stats);
}

class AdminDashboardPendingVerificationsSuccess extends AdminDashboardState {
  final List<UserMissionModel> verifications;
  const AdminDashboardPendingVerificationsSuccess(this.verifications);
}

class AdminDashboardUsersSuccess extends AdminDashboardState {
  final List<UserModel> users;
  const AdminDashboardUsersSuccess(this.users);
}

class AdminDashboardUserDetailSuccess extends AdminDashboardState {
  final UserModel user;
  const AdminDashboardUserDetailSuccess(this.user);
}

class AdminDashboardVerifySuccess extends AdminDashboardState {
  final UserMissionModel userMission;
  const AdminDashboardVerifySuccess(this.userMission);
}

class AdminDashboardAdjustPointsSuccess extends AdminDashboardState {
  final PointsAdjustmentResultModel result;
  const AdminDashboardAdjustPointsSuccess(this.result);
}

class AdminDashboardFailure extends AdminDashboardState {
  final String message;
  const AdminDashboardFailure(this.message);
}
