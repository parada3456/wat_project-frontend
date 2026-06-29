
part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;
  const LoginSubmittedEvent(this.email, this.password);
}

class RegisterSubmittedEvent extends LoginEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const RegisterSubmittedEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class ForgotPasswordSubmittedEvent extends LoginEvent {
  final String email;
  const ForgotPasswordSubmittedEvent(this.email);
}

class ResetPasswordSubmittedEvent extends LoginEvent {
  final String token;
  final String newPassword;
  const ResetPasswordSubmittedEvent(this.token, this.newPassword);
}

class LogoutRequestedEvent extends LoginEvent {
  const LogoutRequestedEvent();
}
