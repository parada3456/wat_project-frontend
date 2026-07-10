import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class VerifyAdminMissionUseCase {
  final AdminRepository _repository;

  VerifyAdminMissionUseCase(this._repository);

  Future<Either<Failure, UserMissionModel>> call(
    String id,
    bool approved,
    String? rejectionReason,
  ) async {
    try {
      final result = await _repository.verifyMission(
        id,
        approved,
        rejectionReason,
      );
      return Right(result.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
