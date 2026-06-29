// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';
// import 'package:wat_project_frontend/domain/models/home_data.dart';
// import 'package:wat_project_frontend/domain/models/user_model.dart';
// import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
// import 'package:wat_project_frontend/domain/models/mission_model.dart';
// import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
// import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
// import 'package:wat_project_frontend/domain/usecases/get_home_data_usecase.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final GetHomeDataUseCase _getHomeDataUseCase;

//   HomeBloc(this._getHomeDataUseCase) : super(HomeState()) {
//     on<HomeFetched>(_onHomeFetched);
//   }

//   Future<void> _onHomeFetched(
//     HomeFetched event,
//     Emitter<HomeState> emit,
//   ) async {
//     emit(
//       state.copyWith(
//             status: const UIStatus.loading()
//       ),
//     );
//     final result = await _getHomeDataUseCase();
//     result.fold(
//       (failure) {
//         // Fallback to mock data for demonstration
//         // final mockData = _getMockHomeData();
//         // emit(HomeSuccess(mockData));
//         print("home bloc failure: _getHomeDataUseCase fail ");
//       },
//       (homeData) => state.copyWith(
//             areaStatus: const UIStatus.loading(),
//             HomeData(
//               user: user, 
//               currentPhase: currentPhase, 
//               allPhases: allPhases, 
//               phaseMissions: phaseMissions)
//           ),
//     );
//   }

//   // HomeData _getMockHomeData() {
//   //   final mockUser = UserModel(
//   //     id: 'mock-user-123',
//   //     email: 'somchai@chula.ac.th',
//   //     currentPhaseId: 'phase-1',
//   //     totalLifetimePoints: 800,
//   //     currentPhasePoints: 300,
//   //     missionStreak: 4,
//   //     createdAt: DateTime.now(),
//   //     updatedAt: DateTime.now(),
//   //   );

//   //   final mockPhases = [
//   //     JourneyPhaseModel(
//   //       phaseId: 'phase-1',
//   //       phaseNumber: 1,
//   //       title: 'Preparation & Booking',
//   //       description: 'Complete your initial preparations, flights and visa documentations.',
//   //       createdAt: DateTime.now(),
//   //       updatedAt: DateTime.now(),
//   //     ),
//   //     JourneyPhaseModel(
//   //       phaseId: 'phase-2',
//   //       phaseNumber: 2,
//   //       title: 'Pre-Departure Orientation',
//   //       description: 'Learn about US customs, housing arrangements, and safety rules.',
//   //       createdAt: DateTime.now(),
//   //       updatedAt: DateTime.now(),
//   //     ),
//   //   ];

//   //   final mockMissions = [
//   //     MissionDetailModel(
//   //       mission: MissionModel(
//   //         missionId: 'm-1',
//   //         phaseId: 'phase-1',
//   //         title: 'Visa Document Verification',
//   //         description: 'Submit your DS-2019 and passport details for administrative review.',
//   //         basePoints: 500,
//   //         isMandatory: true,
//   //         verificationType: VerificationType.upload,
//   //         createdAt: DateTime.now(),
//   //         updatedAt: DateTime.now(),
//   //       ),
//   //       userMission: UserMissionModel(
//   //         userMissionId: 'um-1',
//   //         userId: mockUser.id,
//   //         missionId: 'm-1',
//   //         status: UserMissionStatus.inProgress,
//   //         calculatedDueDate: DateTime.now().add(const Duration(days: 3)),
//   //         basePointsEarned: 0,
//   //         speedBonusPoints: 0,
//   //         streakBonusPoints: 0,
//   //         firstCompleterBonusPoints: 0,
//   //         totalPointsEarned: 0,
//   //         createdAt: DateTime.now(),
//   //         updatedAt: DateTime.now(),
//   //       ),
//   //       tasks: [],
//   //       userTasks: [],
//   //     ),
//   //     MissionDetailModel(
//   //       mission: MissionModel(
//   //         missionId: 'm-2',
//   //         phaseId: 'phase-1',
//   //         title: 'Flight Ticket Booking',
//   //         description: 'Book your flight ticket and submit the itinerary details.',
//   //         basePoints: 300,
//   //         isMandatory: false,
//   //         verificationType: VerificationType.none,
//   //         createdAt: DateTime.now(),
//   //         updatedAt: DateTime.now(),
//   //       ),
//   //       userMission: UserMissionModel(
//   //         userMissionId: 'um-2',
//   //         userId: mockUser.id,
//   //         missionId: 'm-2',
//   //         status: UserMissionStatus.completed,
//   //         calculatedDueDate: DateTime.now().add(const Duration(days: 5)),
//   //         basePointsEarned: 300,
//   //         speedBonusPoints: 0,
//   //         streakBonusPoints: 0,
//   //         firstCompleterBonusPoints: 0,
//   //         totalPointsEarned: 300,
//   //         createdAt: DateTime.now(),
//   //         updatedAt: DateTime.now(),
//   //       ),
//   //       tasks: [],
//   //       userTasks: [],
//   //     ),
//   //   ];

//   //   return HomeData(
//   //     user: mockUser,
//   //     currentPhase: mockPhases[0],
//   //     allPhases: mockPhases,
//   //     phaseMissions: mockMissions,
//   //     isMock: true,
//   //   );
//   // }
// }
