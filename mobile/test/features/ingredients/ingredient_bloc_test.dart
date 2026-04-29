import 'package:flutter_test/flutter_test.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/add_ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/delete_ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_expiring_soon.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_ingredients.dart';
import 'package:nomnom_mobile/features/ingredients/domain/usecases/update_ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';

class _FakeRepo implements IngredientRepository {
  List<Ingredient> data;
  _FakeRepo(this.data);

  @override
  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    data = [...data, ingredient];
    return ingredient;
  }

  @override
  Future<void> deleteIngredient(String id) async =>
      data = data.where((i) => i.id != id).toList();

  @override
  Future<List<Ingredient>> getExpiringSoon() async => data;

  @override
  Future<List<Ingredient>> getIngredients() async => data;

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) async => ingredient;
}

IngredientBloc _build(IngredientRepository repo) => IngredientBloc(
      getIngredients: GetIngredients(repo),
      addIngredient: AddIngredient(repo),
      updateIngredient: UpdateIngredient(repo),
      deleteIngredient: DeleteIngredient(repo),
      getExpiringSoon: GetExpiringSoon(repo),
    );

Ingredient _ing(String id, String name) => Ingredient(
      id: id,
      name: name,
      quantity: 1,
      unit: 'pcs',
      expirationDate: DateTime(2030, 1, 1),
    );

void main() {
  group('IngredientBloc user-switching', () {
    test('ResetIngredients clears items and status', () async {
      final bloc = _build(_FakeRepo([_ing('1', 'A1')]));
      bloc.add(const LoadIngredients());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(bloc.state.items, hasLength(1));

      bloc.add(const ResetIngredients());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(bloc.state.items, isEmpty);
      expect(bloc.state.status, IngredientStatus.initial);
      await bloc.close();
    });

    test('Reset then Load returns the new user list, not the old one',
        () async {
      final repo = _FakeRepo([_ing('1', 'A1')]);
      final bloc = _build(repo);

      bloc.add(const LoadIngredients());
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(bloc.state.items.map((i) => i.name), ['A1']);

      // Simulate logout + login as user B with different data.
      bloc.add(const ResetIngredients());
      repo.data = [_ing('2', 'B1')];
      bloc.add(const LoadIngredients());
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(bloc.state.items.map((i) => i.name), ['B1']);
      await bloc.close();
    });
  });
}
