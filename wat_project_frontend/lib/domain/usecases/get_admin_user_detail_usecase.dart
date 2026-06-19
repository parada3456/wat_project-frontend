import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class GetAdminUserDetailUseCase {
  final AdminRepository _repository;

  GetAdminUserDetailUseCase(this._repository);

  Future<Either<Failure, UserModel>> call(String id) async {
    try {
      final result = await _repository.getUserDetail(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
