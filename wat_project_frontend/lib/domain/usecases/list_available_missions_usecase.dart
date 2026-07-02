import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class ListAvailableMissionsUseCase {
  final MissionRepository _repository;

  ListAvailableMissionsUseCase(this._repository);

  Future<Either<Failure, List<MissionDetailModel>>> call() async {
    try {
      final userMissions = await _repository.listMissions();
      
      final detailsList = await Future.wait(
        userMissions.map((um) async {
          try {
            final detail = await _repository.getMissionDetail(um.userMissionId);
            final tasks = await _repository.getTasksByIds(detail.tasks);
            final userTasks = await _repository.getUserTasksByIds(detail.userTasks);

            return MissionDetailModel(
              mission: detail.mission.toModel(),
              userMission: detail.userMission.toModel(),
              tasks: tasks.map((e) => e.toModel()).toList(),
              userTasks: userTasks.map((e) => e.toModel()).toList(),
            );
          } catch (_) {
            return null;
          }
        }),
      );

      final missions = detailsList
          .where((d) => d != null)
          .cast<MissionDetailModel>()
          .toList();

      return Right(missions);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
