import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class ListAvailableMissionsUseCase {
  final MissionRepository _repository;

  ListAvailableMissionsUseCase(this._repository);

  Future<Either<Failure, List<UserMissionModel>>> call() async {
    try {
      final missions = await _repository.listMissions();
      return Right(missions);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
