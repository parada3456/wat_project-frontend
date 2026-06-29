import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_profile.dart';

@injectable
class GetProfileUseCase {
  final UserRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, UserProfileModel>> call() async {
    try {
      final response = await _repository.getProfile();
      return Right(UserProfileModel(
        user: response.userAccount.toModel(),
        profile: response.userAccount.toProfileModel(),
        creditScore: response.creditScore.toModel(),
        userJobs: response.userJobs?.map((e) => e.toModel()).toList() ?? [],
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
