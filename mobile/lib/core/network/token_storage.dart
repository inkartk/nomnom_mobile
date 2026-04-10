import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenStorage {
  static const _key = 'nomnom_jwt';
  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() => _storage.read(key: _key);

  Future<void> saveToken(String token) => _storage.write(key: _key, value: token);

  Future<void> clearToken() => _storage.delete(key: _key);
}
