import {
  BadRequestException,
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { Response } from 'express';
import * as bcrypt from 'bcrypt';
import * as crypto from 'crypto';
import { Resend } from 'resend';

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

    const verificationToken = this.generateVerificationToken();
    const verificationTokenHash = this.hashToken(verificationToken);
    const verificationExpiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);

    const passwordHash = await bcrypt.hash(dto.password, 10);
    const user = await this.prisma.user.create({
      data: {
        name: dto.name,
        email: dto.email.toLowerCase(),
        passwordHash,
        emailVerificationTokenHash: verificationTokenHash,
        emailVerificationExpiresAt: verificationExpiresAt,
      },
    });

    await this.sendVerificationEmail(user.email, verificationToken);
    response.clearCookie(this.cookieName, {
      httpOnly: true,
      sameSite: 'lax',
      secure: this.isProduction,
    });

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

    if (!user.emailVerified) {
      throw new UnauthorizedException('Please verify your email before logging in');
    }

    this.setAuthCookie(response, user.id, user.email);
    return UserResponseDto.fromEntity(user);
  }

  async verifyEmail(token: string): Promise<void> {
    const tokenHash = this.hashToken(token);
    const user = await this.prisma.user.findFirst({
      where: {
        emailVerificationTokenHash: tokenHash,
      },
    });

    if (!user) {
      throw new BadRequestException('Invalid verification token');
    }

    if (!user.emailVerificationExpiresAt || user.emailVerificationExpiresAt.getTime() < Date.now()) {
      throw new BadRequestException('Verification token expired');
    }

    await this.prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: true,
        emailVerificationTokenHash: null,
        emailVerificationExpiresAt: null,
      },
    });
  }

  async resendVerification(email: string): Promise<void> {
    const normalizedEmail = email.toLowerCase();
    const user = await this.prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (!user || user.emailVerified) {
      return;
    }

    const verificationToken = this.generateVerificationToken();
    const verificationTokenHash = this.hashToken(verificationToken);
    const verificationExpiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);

    await this.prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerificationTokenHash: verificationTokenHash,
        emailVerificationExpiresAt: verificationExpiresAt,
      },
    });

    await this.sendVerificationEmail(user.email, verificationToken);
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

  private generateVerificationToken(): string {
    return crypto.randomBytes(32).toString('hex');
  }

  private hashToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }

  private async sendVerificationEmail(email: string, token: string): Promise<void> {
    const baseUrl = this.configService.get<string>('APP_BASE_URL') ?? 'http://localhost:3000';
    const verifyUrl = `${baseUrl}/api/auth/verify-email?token=${encodeURIComponent(token)}`;

    const apiKey = this.configService.get<string>('RESEND_API_KEY');

    if (!apiKey) {
      console.log(`Email verification URL for ${email}: ${verifyUrl}`);
      return;
    }

    const resend = new Resend(apiKey);
    const from = this.configService.get<string>('RESEND_FROM') ?? 'NomNom <onboarding@resend.dev>';

    try {
      await resend.emails.send({
        from,
        to: email,
        subject: 'Verify your NomNom account',
        text: `Welcome to NomNom! Verify your email by opening this link: ${verifyUrl}`,
        html: `<p>Welcome to NomNom!</p><p>Verify your email by clicking <a href="${verifyUrl}">this link</a>.</p>`,
      });
      console.log(`Verification email sent to ${email}`);
    } catch (err) {
      console.error(`Failed to send verification email to ${email}:`, err);
      console.log(`Fallback verification URL for ${email}: ${verifyUrl}`);
    }
  }
}
