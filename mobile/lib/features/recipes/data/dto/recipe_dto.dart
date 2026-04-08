import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';

part 'recipe_dto.freezed.dart';
part 'recipe_dto.g.dart';

@freezed
class RecipeDto with _$RecipeDto {
  const factory RecipeDto({
    required String id,
    required String title,
    required String description,
    required List<String> instructions,
    required String imageUrl,
  }) = _RecipeDto;

  factory RecipeDto.fromJson(Map<String, dynamic> json) => _$RecipeDtoFromJson(json);
}

extension RecipeDtoX on RecipeDto {
  Recipe toDomain() => Recipe(
        id: id,
        title: title,
        description: description,
        instructions: instructions,
        imageUrl: imageUrl,
      );
}

extension RecipeX on Recipe {
  RecipeDto toDto() => RecipeDto(
        id: id,
        title: title,
        description: description,
        instructions: instructions,
        imageUrl: imageUrl,
      );
}
