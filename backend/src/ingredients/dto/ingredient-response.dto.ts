import { ApiProperty } from '@nestjs/swagger';

export class IngredientResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  quantity!: number;

  @ApiProperty()
  unit!: string;

  @ApiProperty({ type: String, format: 'date-time' })
  expirationDate!: Date;

  static fromEntity(ingredient: {
    id: string;
    name: string;
    quantity: { toNumber(): number } | number;
    unit: string;
    expirationDate: Date;
  }): IngredientResponseDto {
    return {
      id: ingredient.id,
      name: ingredient.name,
      quantity:
        typeof ingredient.quantity === 'number'
          ? ingredient.quantity
          : ingredient.quantity.toNumber(),
      unit: ingredient.unit,
      expirationDate: ingredient.expirationDate,
    };
  }
}
