import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/credit_record.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';

@injectable
class GetCreditScoreHistoryUseCase {
  final UserRepository _repository;

  GetCreditScoreHistoryUseCase(this._repository);

  Future<Either<Failure, List<CreditRecord>>> call() async {
    try {
      print("start usecase get credit score history");
      final result = await _repository.getCreditScoreHistory();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      print("error get credit score history usecase");
      return Left(mapExceptionToFailure(e));
    }
  }
}
