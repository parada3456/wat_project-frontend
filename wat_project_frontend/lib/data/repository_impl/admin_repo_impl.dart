import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/admin/admin_stats_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/points_adjustment_result_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/data/sources/api/admin_api_client.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/admin/verify_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/admin/adjust_points_request.dart';

@injectable
class AdminRepoImpl implements AdminRepository {
  final AdminApiService _adminApi;

  AdminRepoImpl(this._adminApi);

  @override
  Future<AdminStatsEntity> getStats() async {
    return _adminApi.getStats();
  }

  @override
  Future<List<UserMissionEntity>> listPendingVerifications() async {
    final response = await _adminApi.listPendingVerifications();
    return response.data;
  }

  @override
  Future<UserMissionEntity> verifyMission(
    String id,
    bool approved,
    String? rejectionReason,
  ) async {
    final response = await _adminApi.verifyMission(
      id,
      VerifyMissionRequest(
        approved: approved,
        rejectionReason: rejectionReason,
      ),
    );

    UserMissionStatus status;
    switch (response.status) {
      case 'Completed':
        status = UserMissionStatus.completed;
        break;
      case 'Pending_Verification':
        status = UserMissionStatus.pendingVerification;
        break;
      case 'In_Progress':
        status = UserMissionStatus.inProgress;
        break;
      case 'Overdue':
        status = UserMissionStatus.overdue;
        break;
      default:
        status = UserMissionStatus.notStarted;
    }

    return UserMissionEntity(
      userMissionId: response.userMissionId,
      userId: '',
      missionId: '',
      status: status,
      verifiedAt: response.verifiedAt != null
          ? DateTime.parse(response.verifiedAt!)
          : null,
      verifiedBy: response.verifiedBy,
      // basePointsEarned: 0,
      // speedBonusPoints: 0,
      // streakBonusPoints: 0,
      // firstCompleterBonusPoints: 0,
      // totalPointsEarned: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<UserAccountEntity> getUserDetail(String id) async {
    return _adminApi.getUserDetail(id);
  }

  @override
  Future<PointsAdjustmentResultEntity> adjustPoints(
    String id,
    int pointsDelta,
    String reason,
  ) async {
    return _adminApi.adjustPoints(
      id,
      AdjustPointsRequest(pointsDelta: pointsDelta, reason: reason),
    );
  }
}
