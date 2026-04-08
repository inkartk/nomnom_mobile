part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipes extends RecipeEvent {
  const LoadRecipes();
}

class SearchRecipesRequested extends RecipeEvent {
  final String query;
  const SearchRecipesRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadRecipeDetails extends RecipeEvent {
  final String id;
  const LoadRecipeDetails(this.id);

  @override
  List<Object?> get props => [id];
}
