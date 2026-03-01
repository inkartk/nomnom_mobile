import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> searchRecipes(String query);
  Future<List<Recipe>> getRecipes();
  Future<Recipe> getRecipeDetails(String id);
  Future<Recipe> createRecipe(Recipe recipe);
}
