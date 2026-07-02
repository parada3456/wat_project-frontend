import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/points_adjustment_result_model.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class AdjustPointsUseCase {
  final AdminRepository _repository;

  AdjustPointsUseCase(this._repository);

  Future<Either<Failure, PointsAdjustmentResultModel>> call(String id, int pointsDelta, String reason) async {
    try {
      final pointsAdjustmentResultEntity = await _repository.adjustPoints(id, pointsDelta, reason);
      return Right(pointsAdjustmentResultEntity.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
