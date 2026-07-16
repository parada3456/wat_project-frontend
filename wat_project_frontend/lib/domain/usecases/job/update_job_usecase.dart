import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class UpdateJobUseCase {
  final JobRepository _repository;

  UpdateJobUseCase(this._repository);

  Future<Either<Failure, JobPostingModel>> call(String id, JobPostingModel job) async {
    try {
      final updatedJob = await _repository.updateJob(id, job);
      return Right(updatedJob.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
