import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/entities/gamification/leaderboard_entry.dart';
import 'package:wat_project_frontend/data/entities/user/short_user_entity.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/domain/usecases/journey_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/gamification_usecases.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';

class MockListJourneyPhasesUseCase extends Mock
    implements ListJourneyPhasesUseCase {}

class MockAdvancePhaseUseCase extends Mock implements AdvancePhaseUseCase {}

class MockGetJourneyHistoryUseCase extends Mock
    implements GetJourneyHistoryUseCase {}

class MockGetLeaderboardUseCase extends Mock
    implements GetLeaderboardUseCase {}

void main() {
  late MockListJourneyPhasesUseCase mockListJourneyPhasesUseCase;
  late MockAdvancePhaseUseCase mockAdvancePhaseUseCase;
  late MockGetJourneyHistoryUseCase mockGetJourneyHistoryUseCase;
  late MockGetLeaderboardUseCase mockGetLeaderboardUseCase;
  late JourneyGamificationBloc bloc;

  setUp(() {
    mockListJourneyPhasesUseCase = MockListJourneyPhasesUseCase();
    mockAdvancePhaseUseCase = MockAdvancePhaseUseCase();
    mockGetJourneyHistoryUseCase = MockGetJourneyHistoryUseCase();
    mockGetLeaderboardUseCase = MockGetLeaderboardUseCase();
    bloc = JourneyGamificationBloc(
      mockListJourneyPhasesUseCase,
      mockAdvancePhaseUseCase,
      mockGetJourneyHistoryUseCase,
      mockGetLeaderboardUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is JourneyGamificationInitial', () {
    expect(bloc.state, equals(const JourneyGamificationState.initial()));
  });

  blocTest<JourneyGamificationBloc, JourneyGamificationState>(
    'emits [loading, leaderboardLoadSuccess] when LeaderboardRequested is successful',
    build: () {
      final leaderboard = [
        LeaderboardEntry(
          rank: 1,
          user: ShortUserEntity(userId: "1", name: 'Top Student', avatarUrl: 'url'),
          points: 1000,
          streak: 5,
          badges: [],
        ),
      ];
      when(() => mockGetLeaderboardUseCase(any(), any()))
          .thenAnswer((_) async => Right(leaderboard));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const JourneyGamificationEvent.leaderboardRequested()),
    expect: () => [
      const JourneyGamificationState.loading(),
      isA<LeaderboardLoadSuccess>(),
    ],
  );

  blocTest<JourneyGamificationBloc, JourneyGamificationState>(
    'emits [loading, failure] when LeaderboardRequested fails',
    build: () {
      when(() => mockGetLeaderboardUseCase(any(), any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const JourneyGamificationEvent.leaderboardRequested()),
    expect: () => [
      const JourneyGamificationState.loading(),
      const JourneyGamificationState.failure('Server Error'),
    ],
  );
}

