import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class CreateExpenseUseCase {
  final ExpenseRepository _repository;

  CreateExpenseUseCase(this._repository);

  Future<Either<Failure, bool>> call(CreateExpenseRequest request) async {
    try {
      await _repository.createExpense(request);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
