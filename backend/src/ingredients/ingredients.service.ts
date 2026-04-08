import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { IngredientResponseDto } from './dto/ingredient-response.dto';
import { UpsertIngredientDto } from './dto/upsert-ingredient.dto';

@Injectable()
export class IngredientsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(userId: string, dto: UpsertIngredientDto): Promise<IngredientResponseDto> {
    const ingredient = await this.prisma.ingredient.create({
      data: {
        id: dto.id,
        name: dto.name,
        quantity: dto.quantity,
        unit: dto.unit,
        expirationDate: dto.expirationDate,
        userId,
      },
    });

    return IngredientResponseDto.fromEntity(ingredient);
  }

  async findAll(userId: string): Promise<IngredientResponseDto[]> {
    const items = await this.prisma.ingredient.findMany({
      where: { userId },
      orderBy: { expirationDate: 'asc' },
    });

    return items.map(IngredientResponseDto.fromEntity);
  }

  async findExpiringSoon(userId: string): Promise<IngredientResponseDto[]> {
    const now = new Date();
    const inThreeDays = new Date(now.getTime() + 3 * 24 * 60 * 60 * 1000);

    const items = await this.prisma.ingredient.findMany({
      where: {
        userId,
        expirationDate: {
          gte: now,
          lte: inThreeDays,
        },
      },
      orderBy: { expirationDate: 'asc' },
    });

    return items.map(IngredientResponseDto.fromEntity);
  }

  async update(userId: string, id: string, dto: UpsertIngredientDto): Promise<IngredientResponseDto> {
    await this.ensureOwnership(userId, id);

    const ingredient = await this.prisma.ingredient.update({
      where: { id },
      data: {
        name: dto.name,
        quantity: dto.quantity,
        unit: dto.unit,
        expirationDate: dto.expirationDate,
      },
    });

    return IngredientResponseDto.fromEntity(ingredient);
  }

  async remove(userId: string, id: string): Promise<void> {
    await this.ensureOwnership(userId, id);
    await this.prisma.ingredient.delete({ where: { id } });
  }

  private async ensureOwnership(userId: string, id: string) {
    const ingredient = await this.prisma.ingredient.findFirst({
      where: { id, userId },
      select: { id: true },
    });

    if (!ingredient) {
      throw new NotFoundException('Ingredient not found');
    }
  }
}
