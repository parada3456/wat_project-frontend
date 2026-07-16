import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

@injectable
class PatchJobUseCase {
  final JobRepository _repository;

  PatchJobUseCase(this._repository);

  Future<Either<Failure, void>> call(String id, Map<String, dynamic> body) async {
    try {
      await _repository.patchJob(id, body);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
