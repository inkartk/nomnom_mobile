import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/data/datasources/favorites_api.dart';
import 'package:nomnom_mobile/features/favorites/data/dto/favorite_recipe_dto.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesApi _api;
  const FavoritesRepositoryImpl(this._api);

  @override
  Future<List<FavoriteRecipe>> getFavorites() async {
    final dtos = await _api.getFavorites();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addFavorite(String recipeId) => _api.addFavorite(recipeId);

  @override
  Future<void> removeFavorite(String recipeId) => _api.removeFavorite(recipeId);
}
