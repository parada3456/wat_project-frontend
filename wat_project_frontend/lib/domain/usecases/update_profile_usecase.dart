import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_profile.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';

import 'package:wat_project_frontend/domain/models/user_job_model.dart';

@injectable
class UpdateProfileUseCase {
  final UserRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call(String firstName, String lastName, String bio, String avatarUrl) async {
    try {
      await _repository.updateProfile(UpdateProfileRequest(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        avatarUrl: avatarUrl,
      ));
      final response = await _repository.getProfile();
      return Right(UserProfile(
        user: response.user.toModel(),
        profile: response.profile.toModel(),
        creditScore: response.creditScore.toModel(),
        userJobs: response.userJobs?.map((jobId) => UserJobModel(
          userId: response.user.id,
          jobId: jobId,
          assignedAt: DateTime.now(),
          isMain: true,
        )).toList() ?? [],
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
