import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class ListJobsUseCase {
  final JobRepository _repository;

  ListJobsUseCase(this._repository);

  Future<Either<Failure, List<JobPostingModel>>> call(Map<String, dynamic> filters) async {
    try {
      final jobs = await _repository.listJobs(filters);
      return Right(jobs.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
