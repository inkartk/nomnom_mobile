import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { RecipeResponseDto } from './dto/recipe-response.dto';
import { UpsertRecipeDto } from './dto/upsert-recipe.dto';

@Injectable()
export class RecipesService {
  constructor(private readonly prisma: PrismaService) {}

  async create(userId: string, dto: UpsertRecipeDto): Promise<RecipeResponseDto> {
    const recipe = await this.prisma.recipe.create({
      data: {
        id: dto.id,
        title: dto.title,
        description: dto.description,
        instructions: dto.instructions,
        imageUrl: dto.imageUrl,
        authorId: userId,
      },
    });

    return RecipeResponseDto.fromEntity(recipe);
  }

  async findAll(): Promise<RecipeResponseDto[]> {
    const recipes = await this.prisma.recipe.findMany({
      orderBy: { createdAt: 'desc' },
    });

    return recipes.map(RecipeResponseDto.fromEntity);
  }

  async search(query: string): Promise<RecipeResponseDto[]> {
    const normalizedQuery = query.trim();

    if (!normalizedQuery) {
      return this.findAll();
    }

    const recipes = await this.prisma.recipe.findMany({
      where: {
        OR: [
          { title: { contains: normalizedQuery, mode: 'insensitive' } },
          { description: { contains: normalizedQuery, mode: 'insensitive' } },
        ],
      },
      orderBy: { createdAt: 'desc' },
    });

    return recipes.map(RecipeResponseDto.fromEntity);
  }

  async findOne(id: string): Promise<RecipeResponseDto> {
    const recipe = await this.prisma.recipe.findUnique({ where: { id } });

    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }

    return RecipeResponseDto.fromEntity(recipe);
  }
}
