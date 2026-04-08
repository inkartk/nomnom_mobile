import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/data/dto/favorite_recipe_dto.dart';
import 'package:nomnom_mobile/features/recipes/data/datasources/mock_recipes_remote_data_source.dart';

@LazySingleton()
class MockFavoritesRemoteDataSource {
  final MockRecipesRemoteDataSource recipesRemote;
  final Set<String> _favoriteIds = {'r1'};
  final String _userId = 'u1';

  MockFavoritesRemoteDataSource(this.recipesRemote);

  Future<List<FavoriteRecipeDto>> getFavorites() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final recipes = await recipesRemote.getRecipes();
    return recipes
        .where((r) => _favoriteIds.contains(r.id))
        .map((r) => FavoriteRecipeDto(userId: _userId, recipe: r))
        .toList();
  }

  Future<void> addFavorite(String recipeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _favoriteIds.add(recipeId);
  }

  Future<void> removeFavorite(String recipeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _favoriteIds.remove(recipeId);
  }
}
