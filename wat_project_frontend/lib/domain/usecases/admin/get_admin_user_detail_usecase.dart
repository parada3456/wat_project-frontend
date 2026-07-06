import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class GetAdminUserDetailUseCase {
  final AdminRepository _repository;

  GetAdminUserDetailUseCase(this._repository);

  Future<Either<Failure, UserModel>> call(String id) async {
    try {
      final userAccountEntity = await _repository.getUserDetail(id);
      return Right(userAccountEntity.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
