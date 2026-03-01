part of 'favorites_bloc.dart';

enum FavoritesStatus { initial, loading, loaded, error }

enum ActionStatus { idle, submitting, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final ActionStatus actionStatus;
  final List<FavoriteRecipe> items;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.actionStatus = ActionStatus.idle,
    this.items = const [],
    this.errorMessage,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    ActionStatus? actionStatus,
    List<FavoriteRecipe>? items,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, actionStatus, items, errorMessage];
}
