part of 'journey_gamification_bloc.dart';

@freezed
class JourneyGamificationEvent with _$JourneyGamificationEvent {
  const factory JourneyGamificationEvent.journeyPhasesRequested() =
      JourneyPhasesRequested;
  const factory JourneyGamificationEvent.journeyHistoryRequested() =
      JourneyHistoryRequested;
  const factory JourneyGamificationEvent.leaderboardRequested({
    String? scope,
    String? jobId,
  }) = LeaderboardRequested;
  const factory JourneyGamificationEvent.advancePhaseSubmitted() =
      AdvancePhaseSubmitted;
}
