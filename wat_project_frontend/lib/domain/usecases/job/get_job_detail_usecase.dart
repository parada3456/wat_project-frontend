import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class GetJobDetailUseCase {
  final JobRepository _repository;

  GetJobDetailUseCase(this._repository);

  Future<Either<Failure, JobDetailResponse>> call(String jobId) async {
    try {
      final jobDetail = await _repository.getJobDetail(jobId);
      return Right(jobDetail);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
