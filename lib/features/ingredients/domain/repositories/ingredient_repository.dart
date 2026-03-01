import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>> getIngredients();
  Future<Ingredient> addIngredient(Ingredient ingredient);
  Future<Ingredient> updateIngredient(Ingredient ingredient);
  Future<void> deleteIngredient(String id);
  Future<List<Ingredient>> getExpiringSoon();
}
