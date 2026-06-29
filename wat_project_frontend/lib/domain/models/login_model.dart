import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_model.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';


class LoginModel{
  final AuthModel auth;
  final UserModel user;
  final ProfileModel profile;

  LoginModel({
    required this.auth,
    required this.user, 
    required this.profile
  });

}