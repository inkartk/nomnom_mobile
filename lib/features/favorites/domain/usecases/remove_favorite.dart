import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart';

@injectable
class RemoveFavorite {
  final FavoritesRepository repository;
  const RemoveFavorite(this.repository);

  Future<void> call(String recipeId) {
    return repository.removeFavorite(recipeId);
  }
}
