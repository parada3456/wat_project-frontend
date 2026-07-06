import 'package:wat_project_frontend/data/entities/admin/admin_stats_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/points_adjustment_result_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/domain/models/admin_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/admin_models.dart';

abstract class AdminRepository {
  Future<AdminStatsEntity> getStats();
  Future<List<UserMissionEntity>> listPendingVerifications();
  Future<UserMissionEntity> verifyMission(String id, bool approved, String? rejectionReason);
  // Future<List<UserModel>> listUsers(String search);
  Future<UserAccountEntity> getUserDetail(String id);
  Future<PointsAdjustmentResultEntity> adjustPoints(String id, int pointsDelta, String reason);
}
