import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';

part 'ingredient_dto.freezed.dart';
part 'ingredient_dto.g.dart';

@freezed
class IngredientDto with _$IngredientDto {
  const factory IngredientDto({
    required String id,
    required String name,
    required double quantity,
    required String unit,
    required DateTime expirationDate,
  }) = _IngredientDto;

  factory IngredientDto.fromJson(Map<String, dynamic> json) => _$IngredientDtoFromJson(json);
}

extension IngredientDtoX on IngredientDto {
  Ingredient toDomain() => Ingredient(
        id: id,
        name: name,
        quantity: quantity,
        unit: unit,
        expirationDate: expirationDate,
      );
}

extension IngredientX on Ingredient {
  IngredientDto toDto() => IngredientDto(
        id: id,
        name: name,
        quantity: quantity,
        unit: unit,
        expirationDate: expirationDate,
      );
}
