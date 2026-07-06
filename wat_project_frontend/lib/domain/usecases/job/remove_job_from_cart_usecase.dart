import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class RemoveJobFromCartUseCase {
  final JobRepository _repository;

  RemoveJobFromCartUseCase(this._repository);

  Future<Either<Failure, void>> call(String cartItemId) async {
    try {
      await _repository.removeFromCart(cartItemId);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
