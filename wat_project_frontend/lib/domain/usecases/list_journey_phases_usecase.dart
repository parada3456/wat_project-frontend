import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';

@injectable
class ListJourneyPhasesUseCase {
  final JourneyRepository _repository;

  ListJourneyPhasesUseCase(this._repository);

  Future<Either<Failure, List<JourneyPhaseModel>>> call() async {
    try {
      final result = await _repository.listPhases();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
