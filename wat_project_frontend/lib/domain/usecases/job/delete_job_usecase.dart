import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class DeleteJobUseCase {
  final JobRepository _repository;

  DeleteJobUseCase(this._repository);

  Future<Either<Failure, void>> call(String id) async {
    try {
      await _repository.deleteJob(id);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
