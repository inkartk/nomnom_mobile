import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/data/datasources/mock_recipes_remote_data_source.dart';
import 'package:nomnom_mobile/features/recipes/data/dto/recipe_dto.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  final MockRecipesRemoteDataSource remote;
  const RecipeRepositoryImpl(this.remote);

  @override
  Future<List<Recipe>> getRecipes() async {
    final dtos = await remote.getRecipes();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Recipe>> searchRecipes(String query) async {
    final dtos = await remote.searchRecipes(query);
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Recipe> getRecipeDetails(String id) async {
    final dto = await remote.getRecipeDetails(id);
    return dto.toDomain();
  }

  @override
  Future<Recipe> createRecipe(Recipe recipe) async {
    final dto = await remote.createRecipe(recipe.toDto());
    return dto.toDomain();
  }
}
