import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/core/network/token_storage.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final path = response.requestOptions.path;
    if (path.contains('/api/auth/login') || path.contains('/api/auth/register')) {
      final cookies = response.headers['set-cookie'];
      if (cookies != null) {
        for (final cookie in cookies) {
          final token = _extractToken(cookie);
          if (token != null) {
            await _tokenStorage.saveToken(token);
            break;
          }
        }
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _tokenStorage.clearToken();
    }
    handler.next(err);
  }

  String? _extractToken(String cookie) {
    final parts = cookie.split(';');
    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.startsWith('nomnom_session=')) {
        return trimmed.substring('nomnom_session='.length);
      }
    }
    return null;
  }
}
