import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class GetMissionDetailUseCase {
  final MissionRepository _repository;

  GetMissionDetailUseCase(this._repository);

  Future<Either<Failure, MissionDetailModel>> call(String missionId) async {
    try {
      final detail = await _repository.getMissionDetail(missionId);

      final missionModel = detail.mission.toModel();
      final userMissionModel = detail.userMission.toModel();
      final taskModels = detail.tasks.map((e) => e.toModel()).toList();
      final userTaskModels = detail.userTasks.map((e) => e.toModel()).toList();

      return Right(MissionDetailModel(
        mission: missionModel,
        userMission: userMissionModel,
        tasks: taskModels,
        userTasks: userTaskModels,
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
