import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/admin_stats_model.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class GetAdminStatsUseCase {
  final AdminRepository _repository;

  GetAdminStatsUseCase(this._repository);

  Future<Either<Failure, AdminStatsModel>> call() async {
    try {
      final result = await _repository.getStats();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
