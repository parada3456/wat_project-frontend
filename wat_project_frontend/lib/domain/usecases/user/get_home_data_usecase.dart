import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
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
      // listMyMissions now returns PaginationResponse — we only need page 1
      // for the home screen summary (a small set of active missions).
      final myMissionsResponse = await _missionRepository.listMyMissions(
        page: 1,
        pageSize: 50, // fetch enough to cover all active missions on home
      );
      final userMissionEntities = myMissionsResponse.data;
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
                description:
                    'Complete your initial preparations, flights and visa documentations.',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
      );

      // Concurrently fetch details for each user mission
      final detailsList = await Future.wait(
        userMissionEntities.map((um) async {
          try {
            final missionEntity =
                await _missionRepository.getMissionDetail(um.missionId);
            return missionEntity.toModel();
          } catch (_) {
            return null;
          }
        }),
      );
      print("finish task fetch");

      final phaseMissions = detailsList
          .whereType<MissionModel>()
          .where((d) => d.phaseId == currentPhase.phaseId)
          .toList();

      return Right(HomeData(
        user: userModel,
        currentPhase: currentPhase,
        allPhases: phases,
        phaseMissions: phaseMissions,
        isMock: false,
      ));
    } catch (e) {
      print("error occured: $e");
      return Left(mapExceptionToFailure(e));
    }
  }
}
