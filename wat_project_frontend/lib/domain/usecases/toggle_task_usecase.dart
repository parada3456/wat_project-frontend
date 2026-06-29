import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class ToggleTaskUseCase {
  final MissionRepository _repository;

  ToggleTaskUseCase(this._repository);

  Future<Either<Failure, void>> call(String userMissionId, String taskId, bool completed) async {
    try {
      await _repository.toggleTask(userMissionId, taskId, completed);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
