import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteRecipe>> getFavorites();
  Future<void> addFavorite(String recipeId);
  Future<void> removeFavorite(String recipeId);
}
