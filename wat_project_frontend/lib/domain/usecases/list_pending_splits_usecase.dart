import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/expense_split_model.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class ListPendingSplitsUseCase {
  final ExpenseRepository _repository;

  ListPendingSplitsUseCase(this._repository);

  Future<Either<Failure, List<ExpenseSplitModel>>> call() async {
    try {
      final result = await _repository.listPendingExpenses();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
