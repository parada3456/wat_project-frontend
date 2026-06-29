import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class GetMissionDetailUseCase {
  final MissionRepository _repository;

  GetMissionDetailUseCase(this._repository);

  Future<Either<Failure, MissionDetailModel>> call(String missionId) async {
    try {
      final detail = await _repository.getMissionDetail(missionId);
      final tasks = await _repository.getTasksByIds(detail.tasks);
      final userTasks = await _repository.getUserTasksByIds(detail.userTasks);

      final missionModel = detail.mission.toModel();
      final userMissionModel = detail.userMission.toModel();
      final taskModels = tasks.map((e) => e.toModel()).toList();
      final userTaskModels = userTasks.map((e) => e.toModel()).toList();

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
