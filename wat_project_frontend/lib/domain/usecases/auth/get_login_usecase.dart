import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';

@injectable
class GetLoginUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthSessionManager _authManager;

  GetLoginUseCase(
    this._authRepository,
    this._userRepository,
    this._authManager,
  );

  Future<LoginModel> call(String email, String password) async {
    // 1. Login
    final login = await _authRepository.login(email, password);

    // 2. Temporarily save session so we can fetch user profile
    final authModel = login.auth.toModel();
    try {
      await _authManager.saveSession(authModel, null);

      // 4. Save full session with user ID
      await _authManager.saveSession(authModel, login.user.userId);

      return login.toModel();
    } catch (e) {
      // If fetching profile fails, we might want to clear the session or handle it
      await _authManager.clearSession();
      rethrow;
    }
  }
}
