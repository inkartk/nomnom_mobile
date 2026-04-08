import { Body, Controller, Delete, Get, Param, Post, Put, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AuthenticatedUser } from '../auth/types/authenticated-user.type';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { IngredientResponseDto } from './dto/ingredient-response.dto';
import { UpsertIngredientDto } from './dto/upsert-ingredient.dto';
import { IngredientsService } from './ingredients.service';

@ApiTags('ingredients')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('api/ingredients')
export class IngredientsController {
  constructor(private readonly ingredientsService: IngredientsService) {}

  @Post()
  @ApiOkResponse({ type: IngredientResponseDto })
  create(
    @CurrentUser() user: AuthenticatedUser,
    @Body() dto: UpsertIngredientDto,
  ): Promise<IngredientResponseDto> {
    return this.ingredientsService.create(user.userId, dto);
  }

  @Get()
  @ApiOkResponse({ type: IngredientResponseDto, isArray: true })
  findAll(@CurrentUser() user: AuthenticatedUser): Promise<IngredientResponseDto[]> {
    return this.ingredientsService.findAll(user.userId);
  }

  @Get('expiring-soon')
  @ApiOkResponse({ type: IngredientResponseDto, isArray: true })
  findExpiringSoon(@CurrentUser() user: AuthenticatedUser): Promise<IngredientResponseDto[]> {
    return this.ingredientsService.findExpiringSoon(user.userId);
  }

  @Put(':id')
  @ApiOkResponse({ type: IngredientResponseDto })
  update(
    @CurrentUser() user: AuthenticatedUser,
    @Param('id') id: string,
    @Body() dto: UpsertIngredientDto,
  ): Promise<IngredientResponseDto> {
    return this.ingredientsService.update(user.userId, id, dto);
  }

  @Delete(':id')
  remove(@CurrentUser() user: AuthenticatedUser, @Param('id') id: string): Promise<void> {
    return this.ingredientsService.remove(user.userId, id);
  }
}
