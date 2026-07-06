import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class CreateJobReviewUseCase {
  final JobRepository _repository;

  CreateJobReviewUseCase(this._repository);

  Future<Either<Failure, void>> call(CreateReviewRequest request) async {
    try {
      await _repository.createReview(request);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
