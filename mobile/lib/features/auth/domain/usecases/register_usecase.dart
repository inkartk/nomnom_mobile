import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;
  const RegisterUseCase(this.repository);

  Future<User> call({required String name, required String email, required String password}) {
    return repository.register(name: name, email: email, password: password);
  }
}
