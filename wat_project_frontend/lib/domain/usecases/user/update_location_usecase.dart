import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

@injectable
class UpdateLocationUseCase {
  final UserRepository _repository;

  UpdateLocationUseCase(this._repository);

  Future<Either<Failure, bool>> call(double latitude, double longitude) async {
    try {
      await _repository.updateLocation(latitude, longitude);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
