import 'package:wat_project_frontend/domain/models/auth_model.dart';
abstract class AuthRepository {
  Future<AuthModel> register(String email, String password, String firstName, String lastName);
  Future<AuthModel> login(String email, String password);
  Future<void> logout(String refreshToken);
  Future<AuthModel> refresh(String refreshToken);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
}
