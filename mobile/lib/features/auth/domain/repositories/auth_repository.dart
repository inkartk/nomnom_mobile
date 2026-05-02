import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({required String name, required String email, required String password});
  Future<User> getMe();
  Future<void> logout();
  Future<void> verifyEmail(String token);
  Future<void> resendVerification(String email);
}
