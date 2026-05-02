part of 'auth_bloc.dart';

const Object _sentinel = Object();

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  emailUnverified,
  failure,
}

enum FormStatus {
  idle,
  submitting,
  success,
  failure,
  emailVerificationPending,
  resendSuccess,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final FormStatus formStatus;
  final User? user;
  final String? errorMessage;
  final String? pendingEmail;

  const AuthState({
    this.status = AuthStatus.initial,
    this.formStatus = FormStatus.idle,
    this.user,
    this.errorMessage,
    this.pendingEmail,
  });

  AuthState copyWith({
    AuthStatus? status,
    FormStatus? formStatus,
    Object? user = _sentinel,
    Object? errorMessage = _sentinel,
    Object? pendingEmail = _sentinel,
  }) {
    return AuthState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      user: identical(user, _sentinel) ? this.user : user as User?,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      pendingEmail: identical(pendingEmail, _sentinel)
          ? this.pendingEmail
          : pendingEmail as String?,
    );
  }

  @override
  List<Object?> get props =>
      [status, formStatus, user, errorMessage, pendingEmail];
}
