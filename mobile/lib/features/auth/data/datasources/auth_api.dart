import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<UserDto> login(@Body() Map<String, dynamic> body);

  @POST('/api/auth/register')
  Future<UserDto> register(@Body() Map<String, dynamic> body);

  @POST('/api/auth/logout')
  Future<void> logout();

  @GET('/api/auth/verify-email')
  Future<void> verifyEmail(@Query('token') String token);

  @POST('/api/auth/resend-verification')
  Future<void> resendVerification(@Body() Map<String, dynamic> body);
}
