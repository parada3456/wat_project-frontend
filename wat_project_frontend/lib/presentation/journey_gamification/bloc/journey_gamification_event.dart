abstract class JourneyGamificationEvent {
  const JourneyGamificationEvent();
}

class JourneyPhasesRequested extends JourneyGamificationEvent {
  const JourneyPhasesRequested();
}

class JourneyHistoryRequested extends JourneyGamificationEvent {
  const JourneyHistoryRequested();
}

class LeaderboardRequested extends JourneyGamificationEvent {
  final String? scope;
  final String? jobId;

  const LeaderboardRequested({this.scope, this.jobId});
}

class AdvancePhaseSubmitted extends JourneyGamificationEvent {
  const AdvancePhaseSubmitted();
}
