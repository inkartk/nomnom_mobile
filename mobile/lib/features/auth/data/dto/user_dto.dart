import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomnom_mobile/features/auth/domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String name,
    required String email,
    @Default(false) bool emailVerified,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}

extension UserDtoX on UserDto {
  User toDomain() => User(
        id: id,
        name: name,
        email: email,
        emailVerified: emailVerified,
      );
}
