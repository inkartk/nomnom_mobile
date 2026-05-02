import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ResendVerificationUseCase {
  final AuthRepository repository;
  const ResendVerificationUseCase(this.repository);

  Future<void> call(String email) => repository.resendVerification(email);
}
