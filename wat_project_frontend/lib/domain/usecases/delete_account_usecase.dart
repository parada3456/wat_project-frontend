import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';


@injectable
class DeleteAccountUseCase {
  final UserRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, bool>> call(String currentPassword) async {
    try {
      await _repository.deleteAccount(currentPassword);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
