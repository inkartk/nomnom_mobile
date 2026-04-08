import { ApiProperty } from '@nestjs/swagger';

export class RecipeResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty({ type: [String] })
  instructions!: string[];

  @ApiProperty()
  imageUrl!: string;

  static fromEntity(recipe: {
    id: string;
    title: string;
    description: string;
    instructions: string[];
    imageUrl: string;
  }): RecipeResponseDto {
    return {
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      instructions: recipe.instructions,
      imageUrl: recipe.imageUrl,
    };
  }
}
