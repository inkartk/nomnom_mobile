import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class CreateRecipe {
  final RecipeRepository repository;
  const CreateRecipe(this.repository);

  Future<Recipe> call(Recipe recipe) {
    return repository.createRecipe(recipe);
  }
}
