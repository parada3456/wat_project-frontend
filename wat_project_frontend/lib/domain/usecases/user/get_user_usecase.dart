import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

@injectable
class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<UserModel> call() async {
    final userProfileEntity = await _repository.getMe();
    return userProfileEntity.userAccount.toModel();
  }
}
