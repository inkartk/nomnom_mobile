import 'package:equatable/equatable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';

class FavoriteRecipe extends Equatable {
  final String userId;
  final Recipe recipe;

  const FavoriteRecipe({
    required this.userId,
    required this.recipe,
  });

  @override
  List<Object?> get props => [userId, recipe];
}
