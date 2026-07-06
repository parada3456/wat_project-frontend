import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class ListUserMissionsUseCase {
  final MissionRepository _repository;

  ListUserMissionsUseCase(this._repository);

  Future<Either<Failure, List<MissionDetailModel>>> call() async {
    try {
      final userMissions = await _repository.listUserMissions();
      
      final detailsList = await Future.wait(
        userMissions.map((um) async {
          try {
            final detail = await _repository.getMissionDetail(um.userMissionId);
            return MissionDetailModel(
              mission: detail.mission.toModel(),
              userMission: detail.userMission.toModel(),
              tasks: detail.tasks.map((e) => e.toModel()).toList(),
              userTasks: detail.userTasks.map((e) => e.toModel()).toList(),
            );
          } catch (e, stackTrace) {
            print("Error loading detail for user mission ${um.userMissionId}: $e");
            print(stackTrace);
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
