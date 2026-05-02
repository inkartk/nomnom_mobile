import 'dart:async';

import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';

class MockAuthRemoteDataSource {
  UserDto? _cachedUser;

  Future<UserDto> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final localPart = email.split('@').first;
    final displayName = localPart.isEmpty
        ? 'User'
        : localPart[0].toUpperCase() + localPart.substring(1);
    _cachedUser ??= UserDto(id: 'u1', name: displayName, email: email);
    return _cachedUser!;
  }

  Future<UserDto> register({required String name, required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _cachedUser = UserDto(id: 'u1', name: name, email: email);
    return _cachedUser!;
  }

  Future<UserDto> getMe() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (_cachedUser == null) {
      throw StateError('Not authenticated');
    }
    return _cachedUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cachedUser = null;
  }
}
