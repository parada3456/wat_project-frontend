import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class AddJobToCartUseCase {
  final JobRepository _repository;

  AddJobToCartUseCase(this._repository);

  Future<Either<Failure, void>> call(String jobId) async {
    try {
      await _repository.addToCart(jobId);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
