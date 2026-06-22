import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/home_data.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';
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
      final user = await _userRepository.getMe();
      final phases = await _journeyRepository.listPhases();
      final userMissions = await _missionRepository.listMissions();

      // Find current phase matching user's currentPhaseId
      final currentPhase = phases.firstWhere(
        (p) => p.phaseId == user.currentPhaseId,
        orElse: () => phases.isNotEmpty 
            ? phases.first 
            : JourneyPhaseModel(
                phaseId: user.currentPhaseId ?? 'phase-1',
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
            return await _missionRepository.getMissionDetail(um.missionId);
          } catch (_) {
            return null;
          }
        }),
      );

      final phaseMissions = detailsList
          .where((d) => d != null && d.mission.phaseId == currentPhase.phaseId)
          .cast<MissionDetailResponse>()
          .toList();

      return Right(HomeData(
        user: user,
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
