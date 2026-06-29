import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/data/sources/api/admin_api_client.dart';
import 'package:wat_project_frontend/domain/models/admin_stats_model.dart';
import 'package:wat_project_frontend/domain/models/points_adjustment_result_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/admin/verify_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/admin/adjust_points_request.dart';

@injectable
class AdminRepoImpl implements AdminRepository {
  final AdminApiService _adminApi;

  AdminRepoImpl(this._adminApi);

  @override
  Future<AdminStatsModel> getStats() async {
    final response = await _adminApi.getStats();
    return response.toModel();
  }

  @override
  Future<List<UserMissionModel>> listPendingVerifications() async {
    final response = await _adminApi.listPendingVerifications();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<UserMissionModel> verifyMission(String id, bool approved, String? rejectionReason) async {
    final response = await _adminApi.verifyMission(
      id,
      VerifyMissionRequest(approved: approved, rejectionReason: rejectionReason),
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
    return UserMissionModel(
      userMissionId: response.userMissionId,
      status: status,
      verifiedAt: response.verifiedAt != null ? DateTime.parse(response.verifiedAt!) : null,
      verifiedBy: response.verifiedBy,
      userId: '',
      missionId: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // @override
  // Future<List<UserAccountEntity>> listUsers(String search) async {
  //   final response = await _adminApi.listUsers(search);
  //   return response.data.map((e) => e.toModel()).toList();
  // }

  @override
  Future<UserModel> getUserDetail(String id) async {
    final response = await _adminApi.getUserDetail(id);
    return response.toModel();
  }

  @override
  Future<PointsAdjustmentResultModel> adjustPoints(String id, int pointsDelta, String reason) async {
    final response = await _adminApi.adjustPoints(
      id,
      AdjustPointsRequest(pointsDelta: pointsDelta, reason: reason),
    );
    return response.toModel();
  }
}
