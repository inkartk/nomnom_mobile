import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';

@LazySingleton()
class MockAuthRemoteDataSource {
  UserDto? _cachedUser;

  Future<UserDto> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _cachedUser ??= UserDto(id: 'u1', name: 'Alex', email: email);
    return _cachedUser!;
  }

  Future<UserDto> register({required String name, required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _cachedUser = UserDto(id: 'u1', name: name, email: email);
    return _cachedUser!;
  }

  Future<UserDto> getMe() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _cachedUser ??= const UserDto(id: 'u1', name: 'Alex', email: 'alex@nomnom.app');
    return _cachedUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cachedUser = null;
  }
}
