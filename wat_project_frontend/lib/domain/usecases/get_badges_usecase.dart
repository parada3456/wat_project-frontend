import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/badge.dart';

@injectable
class GetBadgesUseCase {
  final UserRepository _repository;

  GetBadgesUseCase(this._repository);

  Future<Either<Failure, List<Badge>>> call() async {
    try {
      final result = await _repository.getBadges();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
