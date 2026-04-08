import { Body, Controller, Get, Param, Post, Query, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';

import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AuthenticatedUser } from '../auth/types/authenticated-user.type';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { RecipeResponseDto } from './dto/recipe-response.dto';
import { UpsertRecipeDto } from './dto/upsert-recipe.dto';
import { RecipesService } from './recipes.service';

@ApiTags('recipes')
@Controller('api/recipes')
export class RecipesController {
  constructor(private readonly recipesService: RecipesService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOkResponse({ type: RecipeResponseDto })
  create(
    @CurrentUser() user: AuthenticatedUser,
    @Body() dto: UpsertRecipeDto,
  ): Promise<RecipeResponseDto> {
    return this.recipesService.create(user.userId, dto);
  }

  @Get()
  @ApiOkResponse({ type: RecipeResponseDto, isArray: true })
  findAll(): Promise<RecipeResponseDto[]> {
    return this.recipesService.findAll();
  }

  @Get('search')
  @ApiQuery({ name: 'query', required: false })
  @ApiOkResponse({ type: RecipeResponseDto, isArray: true })
  search(@Query('query') query = ''): Promise<RecipeResponseDto[]> {
    return this.recipesService.search(query);
  }

  @Get(':id')
  @ApiOkResponse({ type: RecipeResponseDto })
  findOne(@Param('id') id: string): Promise<RecipeResponseDto> {
    return this.recipesService.findOne(id);
  }
}
