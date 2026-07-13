import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class GetAdminUsersUseCase {
  final AdminRepository _repository;

  GetAdminUsersUseCase(this._repository);

  Future<Either<Failure, List<UserModel>>> call(String search) async {
    try {
      final result = await _repository.listUsers(search);
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
