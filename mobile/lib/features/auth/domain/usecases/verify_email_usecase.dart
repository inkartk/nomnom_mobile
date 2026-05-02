import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class VerifyEmailUseCase {
  final AuthRepository repository;
  const VerifyEmailUseCase(this.repository);

  Future<void> call(String token) => repository.verifyEmail(token);
}
