import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@injectable
class DeleteIngredient {
  final IngredientRepository repository;
  const DeleteIngredient(this.repository);

  Future<void> call(String id) {
    return repository.deleteIngredient(id);
  }
}
