import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, MinLength } from 'class-validator';

export class RegisterDto {
  @ApiProperty({ example: 'Alex' })
  @IsString()
  @MinLength(2)
  name!: string;

  @ApiProperty({ example: 'alex@nomnom.app' })
  @IsEmail()
  email!: string;

  @ApiProperty({ example: 'password' })
  @IsString()
  @MinLength(6)
  password!: string;
}
