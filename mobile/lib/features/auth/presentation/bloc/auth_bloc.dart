import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/resend_verification_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/verify_email_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetMeUseCase getMeUseCase;
  final LogoutUseCase logoutUseCase;
  final ResendVerificationUseCase resendVerificationUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getMeUseCase,
    required this.logoutUseCase,
    required this.resendVerificationUseCase,
    required this.verifyEmailUseCase,
  }) : super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<ResendVerificationRequested>(_onResendVerification);
    on<VerifyEmailRequested>(_onVerifyEmail);
    on<AuthFormReset>(_onFormReset);
  }

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await getMeUseCase();
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      formStatus: FormStatus.submitting,
      errorMessage: null,
    ));
    try {
      final user =
          await loginUseCase(email: event.email, password: event.password);
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        formStatus: FormStatus.success,
      ));
    } catch (e) {
      if (_isEmailUnverified(e)) {
        emit(state.copyWith(
          status: AuthStatus.emailUnverified,
          formStatus: FormStatus.failure,
          pendingEmail: event.email,
          errorMessage:
              'Email не подтверждён. Проверьте почту или запросите новое письмо.',
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormStatus.failure,
          errorMessage: _humanizeError(e),
        ));
      }
    }
  }

  Future<void> _onRegister(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      formStatus: FormStatus.submitting,
      errorMessage: null,
    ));
    try {
      await registerUseCase(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        formStatus: FormStatus.emailVerificationPending,
        pendingEmail: event.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        errorMessage: _humanizeError(e),
      ));
    }
  }

  Future<void> _onLogout(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await logoutUseCase();
    } catch (_) {}
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }

  Future<void> _onResendVerification(
      ResendVerificationRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      formStatus: FormStatus.submitting,
      errorMessage: null,
    ));
    try {
      await resendVerificationUseCase(event.email);
      emit(state.copyWith(
        formStatus: FormStatus.resendSuccess,
        pendingEmail: event.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        errorMessage: _humanizeError(e),
      ));
    }
  }

  Future<void> _onVerifyEmail(
      VerifyEmailRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      await verifyEmailUseCase(event.token);
      emit(state.copyWith(formStatus: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        errorMessage: _humanizeError(e),
      ));
    }
  }

  void _onFormReset(AuthFormReset event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      formStatus: FormStatus.idle,
      errorMessage: null,
    ));
  }

  bool _isEmailUnverified(Object error) {
    if (error is DioException) {
      if (error.response?.statusCode != 401) return false;
      final data = error.response?.data;
      if (data is Map) {
        final message = (data['message'] ?? data['error'] ?? '').toString();
        return message.toLowerCase().contains('verify');
      }
      if (data is String) {
        return data.toLowerCase().contains('verify');
      }
    }
    return false;
  }

  String _humanizeError(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      if (data is String && data.isNotEmpty) return data;
      return error.message ?? 'Network error';
    }
    return error.toString();
  }
}
