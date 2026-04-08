import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class SearchRecipes {
  final RecipeRepository repository;
  const SearchRecipes(this.repository);

  Future<List<Recipe>> call(String query) {
    return repository.searchRecipes(query);
  }
}
