import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class CreateJobUseCase {
  final JobRepository _repository;

  CreateJobUseCase(this._repository);

  Future<Either<Failure, JobPostingModel>> call(JobPostingModel job) async {
    try {
      final createdJob = await _repository.createJob(job);
      return Right(createdJob.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
