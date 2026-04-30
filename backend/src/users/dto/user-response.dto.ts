import { ApiProperty } from '@nestjs/swagger';

export class UserResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  email!: string;

  @ApiProperty()
  emailVerified!: boolean;

  static fromEntity(user: { id: string; name: string; email: string; emailVerified?: boolean }): UserResponseDto {
    return {
      id: user.id,
      name: user.name,
      email: user.email,
      emailVerified: user.emailVerified ?? false,
    };
  }
}
