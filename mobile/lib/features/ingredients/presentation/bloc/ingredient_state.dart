part of 'ingredient_bloc.dart';

enum IngredientStatus { initial, loading, loaded, error }

enum FormStatus { idle, submitting, success, failure }

class IngredientState extends Equatable {
  final IngredientStatus status;
  final FormStatus formStatus;
  final List<Ingredient> items;
  final bool showExpiringSoon;
  final String? errorMessage;

  const IngredientState({
    this.status = IngredientStatus.initial,
    this.formStatus = FormStatus.idle,
    this.items = const [],
    this.showExpiringSoon = false,
    this.errorMessage,
  });

  IngredientState copyWith({
    IngredientStatus? status,
    FormStatus? formStatus,
    List<Ingredient>? items,
    bool? showExpiringSoon,
    String? errorMessage,
  }) {
    return IngredientState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      items: items ?? this.items,
      showExpiringSoon: showExpiringSoon ?? this.showExpiringSoon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, formStatus, items, showExpiringSoon, errorMessage];
}
