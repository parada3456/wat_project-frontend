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
      print("start usecase get profile");
      final userProfileEntity = await _repository.getProfile();
      return Right(UserProfileModel(
        user: userProfileEntity.userAccount.toModel(),
        profile: userProfileEntity.userAccount.toProfileModel(),
        creditScore: userProfileEntity.creditScore.toModel(),
        userJobs: userProfileEntity.userJobs.map((e) => e.toModel()).toList(),
      ));
    } catch (e) {
      print("usecase get profile error");
      return Left(mapExceptionToFailure(e));
    }
  }
}
