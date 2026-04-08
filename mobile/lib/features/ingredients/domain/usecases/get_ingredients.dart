import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@injectable
class GetIngredients {
  final IngredientRepository repository;
  const GetIngredients(this.repository);

  Future<List<Ingredient>> call() {
    return repository.getIngredients();
  }
}
