part of 'auth_bloc.dart';

const Object _sentinel = Object();

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
    Object? user = _sentinel,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      user: identical(user, _sentinel) ? this.user : user as User?,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, formStatus, user, errorMessage];
}
