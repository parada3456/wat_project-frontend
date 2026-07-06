import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';


@injectable
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, bool>> call(String refreshToken) async {
    try {
      await _repository.logout(refreshToken);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
