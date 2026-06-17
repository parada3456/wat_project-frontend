import 'package:wat_project_frontend/domain/models/auth_tokens.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final AuthTokens tokens;
  const LoginSuccess(this.tokens);
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(this.errorMessage);
}

class ForgotPasswordSuccess extends LoginState {
  const ForgotPasswordSuccess();
}

class ResetPasswordSuccess extends LoginState {
  const ResetPasswordSuccess();
}
