import { Body, Controller, Get, HttpCode, Post, Query, Res } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Response } from 'express';

import { UserResponseDto } from '../users/dto/user-response.dto';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { ResendVerificationDto } from './dto/resend-verification.dto';
import { RegisterDto } from './dto/register.dto';
import { VerifyEmailDto } from './dto/verify-email.dto';

@ApiTags('auth')
@Controller('api/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  @ApiOkResponse({ type: UserResponseDto })
  register(
    @Body() dto: RegisterDto,
    @Res({ passthrough: true }) response: Response,
  ): Promise<UserResponseDto> {
    return this.authService.register(dto, response);
  }

  @Post('login')
  @HttpCode(200)
  @ApiOkResponse({ type: UserResponseDto })
  login(
    @Body() dto: LoginDto,
    @Res({ passthrough: true }) response: Response,
  ): Promise<UserResponseDto> {
    return this.authService.login(dto, response);
  }

  @Post('logout')
  @HttpCode(200)
  logout(@Res({ passthrough: true }) response: Response) {
    this.authService.logout(response);
    return { success: true };
  }

  @Post('resend-verification')
  @HttpCode(200)
  @ApiOkResponse({
    schema: {
      example: {
        success: true,
      },
    },
  })
  async resendVerification(@Body() dto: ResendVerificationDto): Promise<{ success: true }> {
    await this.authService.resendVerification(dto.email);
    return { success: true };
  }

  @Get('verify-email')
  @ApiOkResponse({
    schema: {
      example: {
        success: true,
      },
    },
  })
  async verifyEmail(@Query() query: VerifyEmailDto): Promise<{ success: true }> {
    await this.authService.verifyEmail(query.token);
    return { success: true };
  }
}
