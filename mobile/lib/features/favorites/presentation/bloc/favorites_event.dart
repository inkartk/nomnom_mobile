part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class AddFavoriteRequested extends FavoritesEvent {
  final String recipeId;
  const AddFavoriteRequested(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

class RemoveFavoriteRequested extends FavoritesEvent {
  final String recipeId;
  const RemoveFavoriteRequested(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}
