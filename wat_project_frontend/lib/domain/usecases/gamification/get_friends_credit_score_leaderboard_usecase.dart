import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_credit_entity.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';

@injectable
class GetFriendsCreditScoreLeaderboardUseCase {
  final JourneyRepository _repository;

  GetFriendsCreditScoreLeaderboardUseCase(this._repository);

  Future<Either<Failure, PaginationResponse<UserCreditEntity>>> call({
    int? page,
    int? pageSize,
  }) async {
    try {
      final result = await _repository.getFriendsCreditScoreLeaderboard(
        page: page,
        pageSize: pageSize,
      );
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
