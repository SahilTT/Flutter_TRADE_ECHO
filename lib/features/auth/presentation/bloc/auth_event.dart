part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class FullNameChanged extends AuthEvent {
  final String fullName;
  const FullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class ConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class TermsAcceptedChanged extends AuthEvent {
  final bool isAccepted;
  const TermsAcceptedChanged(this.isAccepted);

  @override
  List<Object> get props => [isAccepted];
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleConfirmPasswordVisibility extends AuthEvent {}

class PasswordFocusChanged extends AuthEvent {
  final bool hasFocus;
  const PasswordFocusChanged(this.hasFocus);

  @override
  List<Object> get props => [hasFocus];
}

class SignInSubmitted extends AuthEvent {}

class RegisterSubmitted extends AuthEvent {}

class ForgotPasswordSubmitted extends AuthEvent {}

class AuthStatusReset extends AuthEvent {}
