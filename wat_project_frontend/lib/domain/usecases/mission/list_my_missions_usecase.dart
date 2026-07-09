import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/domain/usecases/mission/list_all_missions_usecase.dart';

@injectable
class ListMyMissionsUseCase {
  final MissionRepository _repository;

  ListMyMissionsUseCase(this._repository);

  Future<Either<Failure, PaginatedMissions>> call({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _repository.listMyMissions(
        page: page,
        pageSize: pageSize,
      );
      final models = response.data.map((e) => e.toModel()).toList();
      return Right(PaginatedMissions(
        missions: models,
        pagination: response.pagination,
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
