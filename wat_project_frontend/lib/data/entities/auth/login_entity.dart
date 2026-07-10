import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';
part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  final AuthEntity auth;
  final UserAccountEntity user;

  LoginEntity({required this.auth, required this.user});

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);

  LoginModel toModel() {
    return LoginModel(
      auth: auth.toModel(),
      user: user.toModel(),
      profile: user.toProfileModel(),
    );
  }
}
