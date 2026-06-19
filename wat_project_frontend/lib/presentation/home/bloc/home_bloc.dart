import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/models/home_data.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/mission_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/data/entities/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/user_mission_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';
import 'package:wat_project_frontend/domain/usecases/get_home_data_usecase.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_event.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeBloc(this._getHomeDataUseCase) : super(const HomeInitial()) {
    on<HomeFetched>(_onHomeFetched);
  }

  Future<void> _onHomeFetched(HomeFetched event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    
    final result = await _getHomeDataUseCase();
    
    result.fold(
      (failure) {
        final fallback = _getMockHomeData();
        emit(HomeFailure(failure.message, fallbackData: fallback));
      },
      (data) => emit(HomeSuccess(data)),
    );
  }

  HomeData _getMockHomeData() {
    final mockUser = UserModel(
      id: 'mock-user-123',
      email: 'traveler@watproject.org',
      firstName: 'Alex',
      lastName: 'Wanderer',
      currentPhaseId: 'phase-1',
      totalLifetimePoints: 850,
      currentPhasePoints: 450,
      missionStreak: 3,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    final mockPhases = [
      JourneyPhaseModel(
        phaseId: 'phase-1',
        phaseNumber: 1,
        title: 'Application & Visa prep',
        description: 'Prepare and submit your visa application, book flight tickets, and gather basic documents.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      JourneyPhaseModel(
        phaseId: 'phase-2',
        phaseNumber: 2,
        title: 'Pre-Departure Orientation',
        description: 'Learn about US customs, housing arrangements, and safety rules.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      JourneyPhaseModel(
        phaseId: 'phase-3',
        phaseNumber: 3,
        title: 'On-Site Work',
        description: 'Arrive at your employer location, start your job, and begin exploring.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    final mockMissions = [
      MissionDetailResponse(
        mission: MissionEntity(
          missionId: 'm-1',
          phaseId: 'phase-1',
          title: 'Visa Document Verification',
          description: 'Submit your DS-2019 and passport details for administrative review.',
          basePoints: 500,
          isMandatory: true,
          verificationType: VerificationType.upload,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        userMission: UserMissionEntity(
          userMissionId: 'um-1',
          userId: mockUser.id,
          missionId: 'm-1',
          status: UserMissionStatus.inProgress,
          calculatedDueDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          basePointsEarned: 0,
          speedBonusPoints: 0,
          streakBonusPoints: 0,
          firstCompleterBonusPoints: 0,
          totalPointsEarned: 0,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        tasks: [],
        userTasks: [],
      ),
      MissionDetailResponse(
        mission: MissionEntity(
          missionId: 'm-2',
          phaseId: 'phase-1',
          title: 'Flight Ticket Booking',
          description: 'Book your flight ticket and submit the itinerary details.',
          basePoints: 300,
          isMandatory: false,
          verificationType: VerificationType.none,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        userMission: UserMissionEntity(
          userMissionId: 'um-2',
          userId: mockUser.id,
          missionId: 'm-2',
          status: UserMissionStatus.completed,
          calculatedDueDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
          basePointsEarned: 300,
          speedBonusPoints: 0,
          streakBonusPoints: 0,
          firstCompleterBonusPoints: 0,
          totalPointsEarned: 300,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        tasks: [],
        userTasks: [],
      ),
    ];

    return HomeData(
      user: mockUser,
      currentPhase: mockPhases[0],
      allPhases: mockPhases,
      phaseMissions: mockMissions,
      isMock: true,
    );
  }
}
