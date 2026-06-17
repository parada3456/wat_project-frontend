import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/models/auth_tokens.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, AuthTokens>> call(String email, String password, String firstName, String lastName) async {
    try {
      final result = await _repository.register(email, password, firstName, lastName);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
