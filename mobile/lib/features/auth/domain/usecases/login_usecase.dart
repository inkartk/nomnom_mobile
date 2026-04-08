import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;
  const LoginUseCase(this.repository);

  Future<User> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
