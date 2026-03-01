import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:nomnom_mobile/features/recipes/domain/usecases/get_recipe_details.dart';
import 'package:nomnom_mobile/features/recipes/domain/usecases/get_recipes.dart';
import 'package:nomnom_mobile/features/recipes/domain/usecases/search_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipes getRecipes;
  final SearchRecipes searchRecipes;
  final GetRecipeDetails getRecipeDetails;

  RecipeBloc({
    required this.getRecipes,
    required this.searchRecipes,
    required this.getRecipeDetails,
  }) : super(const RecipeState()) {
    on<LoadRecipes>(_onLoad);
    on<SearchRecipesRequested>(_onSearch);
    on<LoadRecipeDetails>(_onDetails);
  }

  Future<void> _onLoad(LoadRecipes event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(status: RecipeStatus.loading));
    try {
      final items = await getRecipes();
      emit(state.copyWith(status: RecipeStatus.loaded, items: items));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSearch(SearchRecipesRequested event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(status: RecipeStatus.loading));
    try {
      final items = await searchRecipes(event.query);
      emit(state.copyWith(status: RecipeStatus.loaded, items: items));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDetails(LoadRecipeDetails event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(detailsStatus: RecipeStatus.loading));
    try {
      final recipe = await getRecipeDetails(event.id);
      emit(state.copyWith(detailsStatus: RecipeStatus.loaded, selected: recipe));
    } catch (e) {
      emit(state.copyWith(detailsStatus: RecipeStatus.error, errorMessage: e.toString()));
    }
  }
}
