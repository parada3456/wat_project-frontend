import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/user_phase_history_model.dart';
import 'package:wat_project_frontend/domain/models/user_badge_model.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';

abstract class JourneyRepository {
  Future<List<JourneyPhaseModel>> listPhases();
  Future<bool> advancePhase();
  Future<List<UserPhaseHistoryModel>> getHistory();
  Future<List<LeaderboardEntry>> getLeaderboard(String? scope, String? jobId);
  Future<List<UserBadgeModel>> listBadges();
  Future<List<PointLedgerModel>> getCreditHistory();
}
