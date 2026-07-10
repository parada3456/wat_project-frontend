import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';

@injectable
class GoogleLoginUseCase {
  final AuthRepository _repository;

  GoogleLoginUseCase(this._repository);

  Future<Either<Failure, AuthTokens>> call(String idToken) async {
    try {
      final loginEntity = await _repository.googleLogin(idToken);
      return Right(loginEntity.auth.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
