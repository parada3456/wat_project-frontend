import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/entities/gamification/leaderboard_entry.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';

@injectable
class GetLeaderboardUseCase {
  final JourneyRepository _repository;

  GetLeaderboardUseCase(this._repository);

  Future<Either<Failure, List<LeaderboardEntry>>> call(
    String? scope,
    String? jobId,
  ) async {
    try {
      final result = await _repository.getLeaderboard(scope, jobId);
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
