import { ApiProperty } from '@nestjs/swagger';

import { RecipeResponseDto } from '../../recipes/dto/recipe-response.dto';

export class FavoriteResponseDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty({ type: RecipeResponseDto })
  recipe!: RecipeResponseDto;

  static fromEntity(favorite: {
    userId: string;
    recipe: {
      id: string;
      title: string;
      description: string;
      instructions: string[];
      imageUrl: string;
    };
  }): FavoriteResponseDto {
    return {
      userId: favorite.userId,
      recipe: RecipeResponseDto.fromEntity(favorite.recipe),
    };
  }
}
