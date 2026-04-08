import { Controller, Delete, Get, Param, Post, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AuthenticatedUser } from '../auth/types/authenticated-user.type';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { FavoriteResponseDto } from './dto/favorite-response.dto';
import { FavoritesService } from './favorites.service';

@ApiTags('favorites')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('api/favorites')
export class FavoritesController {
  constructor(private readonly favoritesService: FavoritesService) {}

  @Post(':recipeId')
  add(@CurrentUser() user: AuthenticatedUser, @Param('recipeId') recipeId: string): Promise<void> {
    return this.favoritesService.add(user.userId, recipeId);
  }

  @Get()
  @ApiOkResponse({ type: FavoriteResponseDto, isArray: true })
  findAll(@CurrentUser() user: AuthenticatedUser): Promise<FavoriteResponseDto[]> {
    return this.favoritesService.findAll(user.userId);
  }

  @Delete(':recipeId')
  remove(@CurrentUser() user: AuthenticatedUser, @Param('recipeId') recipeId: string): Promise<void> {
    return this.favoritesService.remove(user.userId, recipeId);
  }
}
