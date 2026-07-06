import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';

@injectable
class AdvancePhaseUseCase {
  final JourneyRepository _repository;

  AdvancePhaseUseCase(this._repository);

  Future<Either<Failure, bool>> call() async {
    try {
      final result = await _repository.advancePhase();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
