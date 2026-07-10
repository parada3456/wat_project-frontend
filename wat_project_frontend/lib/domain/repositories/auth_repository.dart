import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';
import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';

abstract class AuthRepository {
  Future<LoginEntity> register(
    String email,
    String password,
    String firstName,
    String lastName,
  );
  Future<LoginEntity> login(String email, String password);
  Future<LoginEntity> googleLogin(String idToken);
  Future<void> logout(String refreshToken);
  Future<AuthEntity> refresh(String refreshToken);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
}
