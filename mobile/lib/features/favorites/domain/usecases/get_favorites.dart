import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart';

@injectable
class GetFavorites {
  final FavoritesRepository repository;
  const GetFavorites(this.repository);

  Future<List<FavoriteRecipe>> call() {
    return repository.getFavorites();
  }
}
