import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/journey_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/journey_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/gamification_usecases.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_event.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_state.dart';

class JourneyGamificationBloc
    extends Bloc<JourneyGamificationEvent, JourneyGamificationState> {
  final ListJourneyPhasesUseCase _listJourneyPhasesUseCase;
  final AdvancePhaseUseCase _advancePhaseUseCase;
  final GetJourneyHistoryUseCase _getJourneyHistoryUseCase;
  final GetLeaderboardUseCase _getLeaderboardUseCase;

  JourneyGamificationBloc(
    this._listJourneyPhasesUseCase,
    this._advancePhaseUseCase,
    this._getJourneyHistoryUseCase,
    this._getLeaderboardUseCase,
  ) : super(const JourneyGamificationInitial()) {
    on<JourneyPhasesRequested>(_onJourneyPhasesRequested);
    on<JourneyHistoryRequested>(_onJourneyHistoryRequested);
    on<LeaderboardRequested>(_onLeaderboardRequested);
    on<AdvancePhaseSubmitted>(_onAdvancePhaseSubmitted);
  }

  Future<void> _onJourneyPhasesRequested(
    JourneyPhasesRequested event,
    Emitter<JourneyGamificationState> emit,
  ) async {
    emit(const JourneyGamificationLoading());
    final result = await _listJourneyPhasesUseCase();
    result.fold(
      (failure) => emit(JourneyGamificationFailure(failure.message)),
      (phases) => emit(JourneyPhasesLoadSuccess(phases)),
    );
  }

  Future<void> _onJourneyHistoryRequested(
    JourneyHistoryRequested event,
    Emitter<JourneyGamificationState> emit,
  ) async {
    emit(const JourneyGamificationLoading());
    final result = await _getJourneyHistoryUseCase();
    result.fold(
      (failure) => emit(JourneyGamificationFailure(failure.message)),
      (history) => emit(JourneyHistoryLoadSuccess(history)),
    );
  }

  Future<void> _onLeaderboardRequested(
    LeaderboardRequested event,
    Emitter<JourneyGamificationState> emit,
  ) async {
    emit(const JourneyGamificationLoading());
    final result = await _getLeaderboardUseCase(event.scope, event.jobId);
    result.fold(
      (failure) => emit(JourneyGamificationFailure(failure.message)),
      (leaderboard) => emit(LeaderboardLoadSuccess(leaderboard)),
    );
  }

  Future<void> _onAdvancePhaseSubmitted(
    AdvancePhaseSubmitted event,
    Emitter<JourneyGamificationState> emit,
  ) async {
    emit(const JourneyGamificationLoading());
    final result = await _advancePhaseUseCase();
    result.fold(
      (failure) => emit(JourneyGamificationFailure(failure.message)),
      (success) => emit(AdvancePhaseSuccess(success)),
    );
  }
}
