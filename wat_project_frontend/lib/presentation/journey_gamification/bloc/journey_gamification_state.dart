import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/user_phase_history_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';

abstract class JourneyGamificationState {
  const JourneyGamificationState();
}

class JourneyGamificationInitial extends JourneyGamificationState {
  const JourneyGamificationInitial();
}

class JourneyGamificationLoading extends JourneyGamificationState {
  const JourneyGamificationLoading();
}

class JourneyPhasesLoadSuccess extends JourneyGamificationState {
  final List<JourneyPhaseModel> phases;
  const JourneyPhasesLoadSuccess(this.phases);
}

class JourneyHistoryLoadSuccess extends JourneyGamificationState {
  final List<UserPhaseHistoryModel> history;
  const JourneyHistoryLoadSuccess(this.history);
}

class LeaderboardLoadSuccess extends JourneyGamificationState {
  final List<LeaderboardEntry> leaderboard;
  const LeaderboardLoadSuccess(this.leaderboard);
}

class AdvancePhaseSuccess extends JourneyGamificationState {
  final bool success;
  const AdvancePhaseSuccess(this.success);
}

class JourneyGamificationFailure extends JourneyGamificationState {
  final String message;
  const JourneyGamificationFailure(this.message);
}
