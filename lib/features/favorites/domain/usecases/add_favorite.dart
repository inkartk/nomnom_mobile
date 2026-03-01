import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart';

@injectable
class AddFavorite {
  final FavoritesRepository repository;
  const AddFavorite(this.repository);

  Future<void> call(String recipeId) {
    return repository.addFavorite(recipeId);
  }
}
