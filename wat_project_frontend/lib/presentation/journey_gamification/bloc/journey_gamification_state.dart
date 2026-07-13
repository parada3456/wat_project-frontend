import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';

part 'journey_gamification_state.freezed.dart';

@freezed
class JourneyGamificationState with _$JourneyGamificationState {
  const factory JourneyGamificationState.initial() = JourneyGamificationInitial;
  const factory JourneyGamificationState.loading() = JourneyGamificationLoading;
  const factory JourneyGamificationState.phasesLoadSuccess(List<JourneyPhaseModel> phases) = JourneyPhasesLoadSuccess;
  const factory JourneyGamificationState.historyLoadSuccess(List<UserPhaseHistoryModel> history) = JourneyHistoryLoadSuccess;
  const factory JourneyGamificationState.leaderboardLoadSuccess(List<LeaderboardEntry> leaderboard) = LeaderboardLoadSuccess;
  const factory JourneyGamificationState.advancePhaseSuccess(bool success) = AdvancePhaseSuccess;
  const factory JourneyGamificationState.failure(String message) = JourneyGamificationFailure;
}
