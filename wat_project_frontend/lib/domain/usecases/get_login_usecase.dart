import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/auth_model.dart';import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
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

  Future<AuthModel> call(String email, String password) async {
    // 1. Login
    final auth = await _authRepository.login(email, password);
    
    // 2. Temporarily save session so we can fetch user profile
    await _authManager.saveSession(auth, null);
    
    try {
      // 3. Get user profile
      final user = await _userRepository.getMe();
      
      // 4. Save full session with user ID
      await _authManager.saveSession(auth, user.id);
      
      return auth;
    } catch (e) {
      // If fetching profile fails, we might want to clear the session or handle it
      await _authManager.clearSession();
      rethrow;
    }
  }
}
