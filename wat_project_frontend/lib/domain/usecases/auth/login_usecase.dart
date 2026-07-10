import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, AuthTokens>> call(
    String email,
    String password,
  ) async {
    try {
      final loginEntity = await _repository.login(email, password);
      print("have login repo result");
      return Right(loginEntity.auth.toModel());
    } catch (e) {
      print("usecase fail");
      return Left(mapExceptionToFailure(e));
    }
  }
}
