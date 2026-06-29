import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_phase_history_model.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';

@injectable
class GetJourneyHistoryUseCase {
  final JourneyRepository _repository;

  GetJourneyHistoryUseCase(this._repository);

  Future<Either<Failure, List<UserPhaseHistoryModel>>> call() async {
    try {
      final result = await _repository.getHistory();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
