import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class ListAllMissionsUseCase {
  final MissionRepository _repository;

  ListAllMissionsUseCase(this._repository);

  Future<Either<Failure, List<MissionModel>>> call() async {
    try {
      final entities = await _repository.listMissions();
      final models = entities.map((e) => e.toModel()).toList();
      return Right(models);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
