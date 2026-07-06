import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class DeleteExpenseUseCase {
  final ExpenseRepository _repository;

  DeleteExpenseUseCase(this._repository);

  Future<Either<Failure, bool>> call(String id) async {
    try {
      await _repository.deleteExpense(id);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
