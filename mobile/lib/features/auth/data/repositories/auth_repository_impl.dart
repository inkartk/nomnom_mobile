import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/data/datasources/mock_auth_remote_data_source.dart';
import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final MockAuthRemoteDataSource remote;
  const AuthRepositoryImpl(this.remote);

  @override
  Future<User> login({required String email, required String password}) async {
    final dto = await remote.login(email: email, password: password);
    return dto.toDomain();
  }

  @override
  Future<User> register({required String name, required String email, required String password}) async {
    final dto = await remote.register(name: name, email: email, password: password);
    return dto.toDomain();
  }

  @override
  Future<User> getMe() async {
    final dto = await remote.getMe();
    return dto.toDomain();
  }

  @override
  Future<void> logout() => remote.logout();
}
