import { ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { Response } from 'express';
import * as bcrypt from 'bcrypt';

import { PrismaService } from '../prisma/prisma.service';
import { UserResponseDto } from '../users/dto/user-response.dto';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  async register(dto: RegisterDto, response: Response): Promise<UserResponseDto> {
    const existingUser = await this.prisma.user.findUnique({
      where: { email: dto.email.toLowerCase() },
    });

    if (existingUser) {
      throw new ConflictException('Email is already registered');
    }

    const passwordHash = await bcrypt.hash(dto.password, 10);
    const user = await this.prisma.user.create({
      data: {
        name: dto.name,
        email: dto.email.toLowerCase(),
        passwordHash,
      },
    });

    this.setAuthCookie(response, user.id, user.email);
    return UserResponseDto.fromEntity(user);
  }

  async login(dto: LoginDto, response: Response): Promise<UserResponseDto> {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email.toLowerCase() },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    this.setAuthCookie(response, user.id, user.email);
    return UserResponseDto.fromEntity(user);
  }

  logout(response: Response) {
    response.clearCookie(this.cookieName, {
      httpOnly: true,
      sameSite: 'lax',
      secure: this.isProduction,
    });
  }

  private setAuthCookie(response: Response, userId: string, email: string) {
    const token = this.jwtService.sign({ sub: userId, email });
    response.cookie(this.cookieName, token, {
      httpOnly: true,
      sameSite: 'lax',
      secure: this.isProduction,
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });
  }

  private get cookieName() {
    return this.configService.get<string>('COOKIE_NAME') ?? 'nomnom_session';
  }

  private get isProduction() {
    return this.configService.get<string>('NODE_ENV') === 'production';
  }
}
