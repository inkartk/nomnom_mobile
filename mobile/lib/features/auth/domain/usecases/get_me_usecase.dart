import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class GetMeUseCase {
  final AuthRepository repository;
  const GetMeUseCase(this.repository);

  Future<User> call() {
    return repository.getMe();
  }
}
