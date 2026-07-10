import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class PayExpenseSplitUseCase {
  final ExpenseRepository _repository;

  PayExpenseSplitUseCase(this._repository);

  Future<Either<Failure, bool>> call(
    String expenseId,
    String splitId,
    File file,
  ) async {
    try {
      await _repository.paySplit(expenseId, splitId, file);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
