import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/models/auth_tokens.dart';

@injectable
class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<Either<Failure, AuthTokens>> call(String refreshToken) async {
    try {
      final result = await _repository.refresh(refreshToken);
      return Right(result.toModel());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
