import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@injectable
class UpdateIngredient {
  final IngredientRepository repository;
  const UpdateIngredient(this.repository);

  Future<Ingredient> call(Ingredient ingredient) {
    return repository.updateIngredient(ingredient);
  }
}
