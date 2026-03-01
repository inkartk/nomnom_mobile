part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

enum FormStatus { idle, submitting, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final FormStatus formStatus;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.formStatus = FormStatus.idle,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    FormStatus? formStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, formStatus, user, errorMessage];
}
