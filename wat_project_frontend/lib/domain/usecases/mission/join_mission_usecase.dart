import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class JoinMissionUseCase {
  final MissionRepository _repository;

  JoinMissionUseCase(this._repository);

  Future<Either<Failure, UserMissionModel>> call(String missionId) async {
    try {
      final userMission = await _repository.joinMission(missionId);
      return Right(userMission);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
