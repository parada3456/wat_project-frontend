import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class GetHomeDataUseCase {
  final UserRepository _userRepository;
  final JourneyRepository _journeyRepository;
  final MissionRepository _missionRepository;

  GetHomeDataUseCase(
    this._userRepository,
    this._journeyRepository,
    this._missionRepository,
  );

  Future<Either<Failure, HomeData>> call() async {
    try {
      print("start homedata fetch");
      final userProfileEntity = await _userRepository.getMe();
      final userProfileModel = userProfileEntity.toModel();
      final userModel = userProfileModel.user;
      print("start phases fetch");
      final phases = (await _journeyRepository.listPhases())
          .map((p) => p.toModel())
          .toList();
      print("start list user mission fetch");
      final userMissions = await _missionRepository.listUserMissions();
      print("finish list user mission fetch");
      // Find current phase matching user's currentPhaseId
      final currentPhase = phases.firstWhere(
        (p) => p.phaseId == userModel.currentPhaseId,
        orElse: () => phases.isNotEmpty 
            ? phases.first 
            : JourneyPhaseModel(
                phaseId: userModel.currentPhaseId ?? 'phase-1',
                phaseNumber: 1,
                title: 'Preparation & Booking',
                description: 'Complete your initial preparations, flights and visa documentations.',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
      );

      // Concurrently fetch details of user's active missions to filter by phase
      final detailsList = await Future.wait(
        userMissions.map((um) async {
          try {
            final detail = await _missionRepository.getMissionDetail(um.userMissionId);

            return MissionDetailModel(
              mission: detail.mission.toModel(),
              userMission: detail.userMission.toModel(),
              tasks: detail.tasks.map((e) => e.toModel()).toList(),
              userTasks: detail.userTasks.map((e) => e.toModel()).toList(),
            );
          } catch (_) {
            return null;
          }
        }),
      );
      print("finish task fetch");

      final phaseMissions = detailsList
          .whereType<MissionDetailModel>()
          .where((d) => d.mission.phaseId == currentPhase.phaseId)
          .toList();

      return Right(HomeData(
        user: userModel,
        currentPhase: currentPhase,
        allPhases: phases,
        phaseMissions: phaseMissions,
        isMock: false,
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
