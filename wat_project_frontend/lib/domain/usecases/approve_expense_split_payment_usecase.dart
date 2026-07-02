import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class ApproveExpenseSplitPaymentUseCase {
  final ExpenseRepository _repository;

  ApproveExpenseSplitPaymentUseCase(this._repository);

  Future<Either<Failure, bool>> call(String expenseId, String splitId) async {
    try {
      await _repository.approveSplit(expenseId, splitId);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
