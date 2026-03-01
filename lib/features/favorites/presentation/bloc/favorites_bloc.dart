import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/favorites/domain/usecases/add_favorite.dart';
import 'package:nomnom_mobile/features/favorites/domain/usecases/get_favorites.dart';
import 'package:nomnom_mobile/features/favorites/domain/usecases/remove_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoad);
    on<AddFavoriteRequested>(_onAdd);
    on<RemoveFavoriteRequested>(_onRemove);
  }

  Future<void> _onLoad(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    try {
      final items = await getFavorites();
      emit(state.copyWith(status: FavoritesStatus.loaded, items: items));
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onAdd(AddFavoriteRequested event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(actionStatus: ActionStatus.submitting));
    try {
      await addFavorite(event.recipeId);
      emit(state.copyWith(actionStatus: ActionStatus.success));
      add(const LoadFavorites());
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onRemove(RemoveFavoriteRequested event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(actionStatus: ActionStatus.submitting));
    try {
      await removeFavorite(event.recipeId);
      emit(state.copyWith(actionStatus: ActionStatus.success));
      add(const LoadFavorites());
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.failure, errorMessage: e.toString()));
    }
  }
}
