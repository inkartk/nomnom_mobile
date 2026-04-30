import { ApiProperty } from '@nestjs/swagger';
import { IsEmail } from 'class-validator';

export class ResendVerificationDto {
  @ApiProperty({ example: 'alex@nomnom.app' })
  @IsEmail()
  email!: string;
}
