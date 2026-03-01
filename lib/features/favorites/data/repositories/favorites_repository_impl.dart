import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/data/datasources/mock_favorites_remote_data_source.dart';
import 'package:nomnom_mobile/features/favorites/data/dto/favorite_recipe_dto.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final MockFavoritesRemoteDataSource remote;
  const FavoritesRepositoryImpl(this.remote);

  @override
  Future<List<FavoriteRecipe>> getFavorites() async {
    final dtos = await remote.getFavorites();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addFavorite(String recipeId) => remote.addFavorite(recipeId);

  @override
  Future<void> removeFavorite(String recipeId) => remote.removeFavorite(recipeId);
}
