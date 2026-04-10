import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/data/datasources/ingredients_api.dart';
import 'package:nomnom_mobile/features/ingredients/data/dto/ingredient_dto.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@LazySingleton(as: IngredientRepository)
class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientsApi _api;
  const IngredientRepositoryImpl(this._api);

  @override
  Future<List<Ingredient>> getIngredients() async {
    final dtos = await _api.getIngredients();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    final dto = await _api.addIngredient(ingredient.toDto().toJson());
    return dto.toDomain();
  }

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) async {
    final dto = await _api.updateIngredient(ingredient.id, ingredient.toDto().toJson());
    return dto.toDomain();
  }

  @override
  Future<void> deleteIngredient(String id) {
    return _api.deleteIngredient(id);
  }

  @override
  Future<List<Ingredient>> getExpiringSoon() async {
    final dtos = await _api.getExpiringSoon();
    return dtos.map((e) => e.toDomain()).toList();
  }
}
