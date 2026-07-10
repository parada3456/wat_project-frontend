import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class ListJobReviewsUseCase {
  final JobRepository _repository;

  ListJobReviewsUseCase(this._repository);

  Future<Either<Failure, List<JobReviewEntity>>> call(String? jobId) async {
    try {
      final reviews = await _repository.listReviews(jobId);
      return Right(reviews);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
