import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

class LoginModel {
  final AuthModel auth;
  final UserModel user;
  final ProfileModel profile;

  LoginModel({required this.auth, required this.user, required this.profile});
}
