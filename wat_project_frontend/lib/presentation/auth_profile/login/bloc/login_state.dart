// import 'package:wat_project_frontend/domain/models/auth_models.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';

// abstract class LoginState {
//   const LoginState();
// }

// class LoginInitial extends LoginState {
//   const LoginInitial();
// }

// class LoginLoading extends LoginState {
//   const LoginLoading();
// }

// class LoginSuccess extends LoginState {
//   final AuthTokens tokens;
//   const LoginSuccess(this.tokens);
// }

// class LoginFailure extends LoginState {
//   final String errorMessage;
//   final ApiError? apiError;

//   const LoginFailure(this.errorMessage, {this.apiError});
// }

// class ForgotPasswordSuccess extends LoginState {
//   const ForgotPasswordSuccess();
// }

// class ResetPasswordSuccess extends LoginState {
//   const ResetPasswordSuccess();
// }
part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(UIStatus.initial()) UIStatus status}) =
      _LoginState;
}
