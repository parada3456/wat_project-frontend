import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_job_model.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

@injectable
class ListApplicationsUseCase {
  final UserRepository _repository;

  ListApplicationsUseCase(this._repository);

  Future<Either<Failure, List<UserJobModel>>> call() async {
    try {
      final response = await _repository.getProfile();
      final userJobs = response.userJobs?.map((jobId) => UserJobModel(
        userId: response.user.id,
        jobId: jobId,
        assignedAt: DateTime.now(),
        isMain: true,
      )).toList() ?? [];
      return Right(userJobs);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
