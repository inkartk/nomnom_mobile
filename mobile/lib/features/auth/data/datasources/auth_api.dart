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
}
