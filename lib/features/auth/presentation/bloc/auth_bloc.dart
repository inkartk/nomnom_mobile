import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:nomnom_mobile/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetMeUseCase getMeUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getMeUseCase,
  }) : super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
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
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      final user = await loginUseCase(email: event.email, password: event.password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user, formStatus: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      final user = await registerUseCase(name: event.name, email: event.email, password: event.password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user, formStatus: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }
}
