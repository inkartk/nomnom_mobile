import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/core/network/token_storage.dart';
import 'package:nomnom_mobile/features/auth/data/datasources/auth_api.dart';
import 'package:nomnom_mobile/features/auth/data/datasources/user_api.dart';
import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final UserApi _userApi;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl(this._authApi, this._userApi, this._tokenStorage);

  @override
  Future<User> login({required String email, required String password}) async {
    final dto = await _authApi.login({'email': email, 'password': password});
    return dto.toDomain();
  }

  @override
  Future<User> register({required String name, required String email, required String password}) async {
    final dto = await _authApi.register({'name': name, 'email': email, 'password': password});
    return dto.toDomain();
  }

  @override
  Future<User> getMe() async {
    final dto = await _userApi.getMe();
    return dto.toDomain();
  }

  @override
  Future<void> logout() async {
    await _authApi.logout();
    await _tokenStorage.clearToken();
  }
}
