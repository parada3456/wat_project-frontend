import 'package:wat_project_frontend/data/entities/gamification/journey_phase_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_phase_history_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';

abstract class JourneyRepository {
  Future<List<JourneyPhaseEntity>> listPhases();
  Future<bool> advancePhase();
  Future<List<UserPhaseHistoryEntity>> getHistory();
  Future<List<LeaderboardEntry>> getLeaderboard(String? scope, String? jobId);
  Future<List<UserBadgeEntity>> listBadges();
  Future<List<PointLedgerEntity>> getCreditHistory();
}
