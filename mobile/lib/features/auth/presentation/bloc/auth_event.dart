part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ResendVerificationRequested extends AuthEvent {
  final String email;

  const ResendVerificationRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyEmailRequested extends AuthEvent {
  final String token;

  const VerifyEmailRequested({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthFormReset extends AuthEvent {
  const AuthFormReset();
}
