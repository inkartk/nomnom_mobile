import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/data/datasources/mock_ingredients_remote_data_source.dart';
import 'package:nomnom_mobile/features/ingredients/data/dto/ingredient_dto.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';

@LazySingleton(as: IngredientRepository)
class IngredientRepositoryImpl implements IngredientRepository {
  final MockIngredientsRemoteDataSource remote;
  const IngredientRepositoryImpl(this.remote);

  @override
  Future<List<Ingredient>> getIngredients() async {
    final dtos = await remote.getIngredients();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    final dto = await remote.addIngredient(ingredient.toDto());
    return dto.toDomain();
  }

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) async {
    final dto = await remote.updateIngredient(ingredient.toDto());
    return dto.toDomain();
  }

  @override
  Future<void> deleteIngredient(String id) {
    return remote.deleteIngredient(id);
  }

  @override
  Future<List<Ingredient>> getExpiringSoon() async {
    final dtos = await remote.getExpiringSoon();
    return dtos.map((e) => e.toDomain()).toList();
  }
}
