import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class GetRecipeDetails {
  final RecipeRepository repository;
  const GetRecipeDetails(this.repository);

  Future<Recipe> call(String id) {
    return repository.getRecipeDetails(id);
  }
}
