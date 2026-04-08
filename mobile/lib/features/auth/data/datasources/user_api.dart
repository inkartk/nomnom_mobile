import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nomnom_mobile/features/auth/data/dto/user_dto.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/api/users/me')
  Future<UserDto> getMe();
}
