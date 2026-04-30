import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/add_ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/delete_ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_expiring_soon.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_ingredients.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/update_ingredient.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

@injectable
class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final GetIngredients getIngredients;
  final AddIngredient addIngredient;
  final UpdateIngredient updateIngredient;
  final DeleteIngredient deleteIngredient;
  final GetExpiringSoon getExpiringSoon;

  IngredientBloc({
    required this.getIngredients,
    required this.addIngredient,
    required this.updateIngredient,
    required this.deleteIngredient,
    required this.getExpiringSoon,
  }) : super(const IngredientState()) {
    on<LoadIngredients>(_onLoad);
    on<ResetIngredients>(_onReset);
    on<LoadExpiringSoon>(_onLoadExpiring);
    on<AddIngredientRequested>(_onAdd);
    on<UpdateIngredientRequested>(_onUpdate);
    on<DeleteIngredientRequested>(_onDelete);
  }

  Future<void> _onReset(ResetIngredients event, Emitter<IngredientState> emit) async {
    emit(const IngredientState());
  }

  Future<void> _onLoad(LoadIngredients event, Emitter<IngredientState> emit) async {
    emit(state.copyWith(status: IngredientStatus.loading));
    try {
      final items = await getIngredients();
      emit(state.copyWith(status: IngredientStatus.loaded, items: items, showExpiringSoon: false));
    } catch (e) {
      emit(state.copyWith(status: IngredientStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadExpiring(LoadExpiringSoon event, Emitter<IngredientState> emit) async {
    emit(state.copyWith(status: IngredientStatus.loading));
    try {
      final items = await getExpiringSoon();
      emit(state.copyWith(status: IngredientStatus.loaded, items: items, showExpiringSoon: true));
    } catch (e) {
      emit(state.copyWith(status: IngredientStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onAdd(AddIngredientRequested event, Emitter<IngredientState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      await addIngredient(event.ingredient);
      emit(state.copyWith(formStatus: FormStatus.success));
      add(const LoadIngredients());
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdate(UpdateIngredientRequested event, Emitter<IngredientState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      await updateIngredient(event.ingredient);
      emit(state.copyWith(formStatus: FormStatus.success));
      add(const LoadIngredients());
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onDelete(DeleteIngredientRequested event, Emitter<IngredientState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submitting));
    try {
      await deleteIngredient(event.id);
      emit(state.copyWith(formStatus: FormStatus.success));
      add(const LoadIngredients());
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.failure, errorMessage: e.toString()));
    }
  }
}
