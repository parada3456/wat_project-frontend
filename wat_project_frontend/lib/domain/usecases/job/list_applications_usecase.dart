import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

@injectable
class ListApplicationsUseCase {
  final UserRepository _repository;

  ListApplicationsUseCase(this._repository);

  Future<Either<Failure, List<UserJobModel>>> call() async {
    try {
      final userProfileEntity = await _repository.getProfile();
      final userJobs = userProfileEntity.userJobs?.map((e) => e.toModel()).toList() ?? [];
      return Right(userJobs);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
