import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class GetJobsByIdsUseCase {
  final JobRepository _repository;

  GetJobsByIdsUseCase(this._repository);

  Future<Either<Failure, List<JobPostingModel>>> call(List<String> ids) async {
    try {
      final jobs = await _repository.getJobsByIds(ids);
      return Right(jobs.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
