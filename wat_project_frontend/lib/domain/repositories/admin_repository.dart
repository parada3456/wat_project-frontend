import 'package:wat_project_frontend/domain/models/admin_stats_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/points_adjustment_result_model.dart';

abstract class AdminRepository {
  Future<AdminStatsModel> getStats();
  Future<List<UserMissionModel>> listPendingVerifications();
  Future<UserMissionModel> verifyMission(String id, bool approved, String? rejectionReason);
  Future<List<UserModel>> listUsers(String search);
  Future<UserModel> getUserDetail(String id);
  Future<PointsAdjustmentResultModel> adjustPoints(String id, int pointsDelta, String reason);
}
