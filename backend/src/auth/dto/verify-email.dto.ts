import { ApiProperty } from '@nestjs/swagger';
import { IsString, MinLength } from 'class-validator';

export class VerifyEmailDto {
  @ApiProperty({ example: '7d8db8f7d2ca56fd6f570d7f92b4ca77e0bd6db7f6f752b31cda8c2cb702af6c' })
  @IsString()
  @MinLength(32)
  token!: string;
}
