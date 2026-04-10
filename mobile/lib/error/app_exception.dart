import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;

  factory AppException.fromDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    final serverMessage = data is Map<String, dynamic> ? data['message'] : null;

    switch (statusCode) {
      case 401:
        return UnauthorizedException(
          serverMessage is String ? serverMessage : 'Invalid credentials',
        );
      case 404:
        return NotFoundException(
          serverMessage is String ? serverMessage : 'Resource not found',
        );
      case 409:
        return ConflictException(
          serverMessage is String ? serverMessage : 'Resource already exists',
        );
      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) {
          return NetworkException('No internet connection');
        }
        return ServerException(
          serverMessage is String ? serverMessage : 'Something went wrong',
        );
    }
  }
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

class ConflictException extends AppException {
  const ConflictException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message);
}
