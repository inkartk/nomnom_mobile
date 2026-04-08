part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object?> get props => [];
}

class LoadIngredients extends IngredientEvent {
  const LoadIngredients();
}

class LoadExpiringSoon extends IngredientEvent {
  const LoadExpiringSoon();
}

class AddIngredientRequested extends IngredientEvent {
  final Ingredient ingredient;
  const AddIngredientRequested(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class UpdateIngredientRequested extends IngredientEvent {
  final Ingredient ingredient;
  const UpdateIngredientRequested(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class DeleteIngredientRequested extends IngredientEvent {
  final String id;
  const DeleteIngredientRequested(this.id);

  @override
  List<Object?> get props => [id];
}
