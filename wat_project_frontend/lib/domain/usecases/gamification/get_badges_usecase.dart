import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/gamification_models.dart';
import 'package:wat_project_frontend/data/entities/gamification/badge_entity.dart';

@injectable
class GetBadgesUseCase {
  final UserRepository _repository;

  GetBadgesUseCase(this._repository);

  Future<Either<Failure, List<Badge>>> call() async {
    try {
      print("start usecase get badge");
      final badgeEntities = await _repository.getBadges();
      return Right(badgeEntities.map((e) => e.toModel()).toList());
    } catch (e) {
      print("error usecase get badge");
      return Left(mapExceptionToFailure(e));
    }
  }
}
