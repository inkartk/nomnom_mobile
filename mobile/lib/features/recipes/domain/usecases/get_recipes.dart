import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class GetRecipes {
  final RecipeRepository repository;
  const GetRecipes(this.repository);

  Future<List<Recipe>> call() {
    return repository.getRecipes();
  }
}
