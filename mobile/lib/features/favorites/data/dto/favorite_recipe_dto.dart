import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/recipes/data/dto/recipe_dto.dart';

part 'favorite_recipe_dto.freezed.dart';
part 'favorite_recipe_dto.g.dart';

@freezed
class FavoriteRecipeDto with _$FavoriteRecipeDto {
  const factory FavoriteRecipeDto({
    required String userId,
    required RecipeDto recipe,
  }) = _FavoriteRecipeDto;

  factory FavoriteRecipeDto.fromJson(Map<String, dynamic> json) => _$FavoriteRecipeDtoFromJson(json);
}

extension FavoriteRecipeDtoX on FavoriteRecipeDto {
  FavoriteRecipe toDomain() => FavoriteRecipe(userId: userId, recipe: recipe.toDomain());
}
