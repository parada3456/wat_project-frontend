part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginSubmitted(String email, String password) =
      LoginSubmittedEvent;

  const factory LoginEvent.registerSubmitted({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) = RegisterSubmittedEvent;

  const factory LoginEvent.forgotPasswordSubmitted(String email) =
      ForgotPasswordSubmittedEvent;

  const factory LoginEvent.resetPasswordSubmitted(
    String token,
    String newPassword,
  ) = ResetPasswordSubmittedEvent;

  const factory LoginEvent.logoutRequested() = LogoutRequestedEvent;
}
