import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/expense_transaction_model.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class ListExpensesUseCase {
  final ExpenseRepository _repository;

  ListExpensesUseCase(this._repository);

  Future<Either<Failure, List<ExpenseTransactionModel>>> call() async {
    try {
      final result = await _repository.listExpenses();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
