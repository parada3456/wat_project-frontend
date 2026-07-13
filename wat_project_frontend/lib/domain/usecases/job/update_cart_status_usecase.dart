import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class UpdateCartStatusUseCase {
  final JobRepository _repository;

  UpdateCartStatusUseCase(this._repository);

  Future<Either<Failure, void>> call(String cartId, String status) async {
    try {
      await _repository.updateCartStatus(cartId, status);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
