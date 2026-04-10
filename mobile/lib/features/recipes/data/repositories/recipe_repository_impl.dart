import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/data/datasources/recipes_api.dart';
import 'package:nomnom_mobile/features/recipes/data/dto/recipe_dto.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesApi _api;
  const RecipeRepositoryImpl(this._api);

  @override
  Future<List<Recipe>> getRecipes() async {
    final dtos = await _api.getRecipes();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Recipe>> searchRecipes(String query) async {
    final dtos = await _api.searchRecipes(query);
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Recipe> getRecipeDetails(String id) async {
    final dto = await _api.getRecipeDetails(id);
    return dto.toDomain();
  }

  @override
  Future<Recipe> createRecipe(Recipe recipe) async {
    final dto = await _api.createRecipe(recipe.toDto().toJson());
    return dto.toDomain();
  }
}
