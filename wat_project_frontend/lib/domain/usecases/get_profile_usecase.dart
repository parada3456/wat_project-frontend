import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_profile.dart';

@injectable
class GetProfileUseCase {
  final UserRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call() async {
    try {
      final response = await _repository.getProfile();
      return Right(UserProfile(
        user: response.user.toModel(),
        profile: response.profile.toModel(),
        creditScore: response.creditScore.toModel(),
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
