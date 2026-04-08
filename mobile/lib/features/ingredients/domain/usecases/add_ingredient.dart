import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@injectable
class AddIngredient {
  final IngredientRepository repository;
  const AddIngredient(this.repository);

  Future<Ingredient> call(Ingredient ingredient) {
    return repository.addIngredient(ingredient);
  }
}
