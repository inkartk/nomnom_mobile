part of 'recipe_bloc.dart';

enum RecipeStatus { initial, loading, loaded, error }

class RecipeState extends Equatable {
  final RecipeStatus status;
  final RecipeStatus detailsStatus;
  final List<Recipe> items;
  final Recipe? selected;
  final String? errorMessage;

  const RecipeState({
    this.status = RecipeStatus.initial,
    this.detailsStatus = RecipeStatus.initial,
    this.items = const [],
    this.selected,
    this.errorMessage,
  });

  RecipeState copyWith({
    RecipeStatus? status,
    RecipeStatus? detailsStatus,
    List<Recipe>? items,
    Recipe? selected,
    String? errorMessage,
  }) {
    return RecipeState(
      status: status ?? this.status,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      items: items ?? this.items,
      selected: selected ?? this.selected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, detailsStatus, items, selected, errorMessage];
}
