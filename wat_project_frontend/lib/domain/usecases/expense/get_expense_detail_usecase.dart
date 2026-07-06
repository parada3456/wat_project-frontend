import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';

@injectable
class GetExpenseDetailUseCase {
  final ExpenseRepository _repository;

  GetExpenseDetailUseCase(this._repository);

  Future<Either<Failure, ExpenseDetailModel>> call(String id) async {
    try {
      final result = await _repository.getExpenseDetail(id);
      final splits = await _repository.getExpenseSplitsByIds(result.splits);

      final transactionModel = result.transaction.toModel();
      final splitModels = splits.map((e) => e.toModel()).toList();

      return Right(ExpenseDetailModel(
        transaction: transactionModel,
        splits: splitModels,
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
