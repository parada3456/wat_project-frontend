import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_info.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

class PaginatedMissions {
  final List<MissionModel> missions;
  final PaginationInfo? pagination;

  const PaginatedMissions({required this.missions, this.pagination});
}

@injectable
class ListAllMissionsUseCase {
  final MissionRepository _repository;

  ListAllMissionsUseCase(this._repository);

  Future<Either<Failure, PaginatedMissions>> call({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _repository.listMissions(
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
