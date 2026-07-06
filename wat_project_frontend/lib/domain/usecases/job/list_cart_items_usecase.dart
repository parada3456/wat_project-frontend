import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class ListCartItemsUseCase {
  final JobRepository _repository;

  ListCartItemsUseCase(this._repository);

  Future<Either<Failure, List<UserCartModel>>> call() async {
    try {
      final cartItems = await _repository.listCart();
      return Right(cartItems.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
