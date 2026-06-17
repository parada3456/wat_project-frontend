import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/credit_record.dart';

@injectable
class GetCreditScoreHistoryUseCase {
  final UserRepository _repository;

  GetCreditScoreHistoryUseCase(this._repository);

  Future<Either<Failure, List<CreditRecord>>> call() async {
    try {
      final result = await _repository.getCreditScoreHistory();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
