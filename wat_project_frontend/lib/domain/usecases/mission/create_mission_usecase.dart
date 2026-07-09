import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class CreateMissionUseCase {
  final MissionRepository _repository;

  CreateMissionUseCase(this._repository);

  Future<Either<Failure, MissionModel>> call(CreateMissionRequest request) async {
    try {
      final mission = await _repository.createMission(request);
      return Right(mission.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
