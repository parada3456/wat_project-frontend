import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class ListPendingVerificationsUseCase {
  final AdminRepository _repository;

  ListPendingVerificationsUseCase(this._repository);

  Future<Either<Failure, List<UserMissionModel>>> call() async {
    try {
      final result = await _repository.listPendingVerifications();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
