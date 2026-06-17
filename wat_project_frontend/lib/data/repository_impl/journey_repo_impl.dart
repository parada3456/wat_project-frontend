import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/user_phase_history_model.dart';
import 'package:wat_project_frontend/domain/models/user_badge_model.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';
import 'package:wat_project_frontend/data/sources/api/journey_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/leaderboard_entry.dart';

@injectable
class JourneyRepoImpl implements JourneyRepository {
  final JourneyApiService _api;

  JourneyRepoImpl(this._api);

  @override
  Future<List<JourneyPhaseModel>> listPhases() async {
    final response = await _api.listPhases();
    return response.map((e) => e.toModel()).toList();
  }

  @override
  Future<bool> advancePhase() async {
    final response = await _api.advancePhase();
    return response['success'] ?? false;
  }

  @override
  Future<List<UserPhaseHistoryModel>> getHistory() async {
    final response = await _api.getHistory();
    return response.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboard(String? scope, String? jobId) async {
    return _api.getLeaderboard(scope, jobId);
  }

  @override
  Future<List<UserBadgeModel>> listBadges() async {
    final response = await _api.listBadges();
    return response.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<PointLedgerModel>> getCreditHistory() async {
    final response = await _api.getCreditHistory();
    return response.map((e) => e.toModel()).toList();
  }
}
