import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';

import 'package:wat_project_frontend/domain/models/job_models.dart';

@injectable
class UpdateProfileUseCase {
  final UserRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, UserProfileModel>> call(String? firstName, String? lastName, String? bio, String? avatarUrl) async {
    try {
      await _repository.updateProfile(UpdateProfileRequest(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        avatarUrl: avatarUrl,
      ));
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
