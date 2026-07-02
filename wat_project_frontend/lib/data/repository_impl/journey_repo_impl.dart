import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/gamification/journey_phase_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_phase_history_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';
import 'package:wat_project_frontend/data/sources/api/journey_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';

@injectable
class JourneyRepoImpl implements JourneyRepository {
  final JourneyApiService _api;

  JourneyRepoImpl(this._api);

  @override
  Future<List<JourneyPhaseEntity>> listPhases() async {
    final response = await _api.listPhases();
    return response.data;
  }

  @override
  Future<bool> advancePhase() async {
    final response = await _api.advancePhase();
    return response.transitioned;
  }

  @override
  Future<List<UserPhaseHistoryEntity>> getHistory() async {
    final response = await _api.getHistory();
    return response.data;
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboard(String? scope, String? jobId) async {
    return _api.getLeaderboard(scope, jobId);
  }

  @override
  Future<List<UserBadgeEntity>> listBadges() async {
    final response = await _api.listBadges();
    return response.data;
  }

  @override
  Future<List<PointLedgerEntity>> getCreditHistory() async {
    final response = await _api.getCreditHistory();
    return response.data;
  }
}
