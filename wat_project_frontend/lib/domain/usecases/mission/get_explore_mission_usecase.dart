import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class GetExploreMissionUseCase {
  final MissionRepository _repository;

  GetExploreMissionUseCase(this._repository);

  Future<Either<Failure, PaginationResponse<MissionModel>>> call({
    int pageSize = 10,
  }) async {
    try {
      final response = await _repository.listExploreMissions(
        pageSize: pageSize,
      );
      final models = response.data.map((e) => e.toModel()).toList();
      return Right(
        PaginationResponse(data: models, pagination: response.pagination),
      );
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
