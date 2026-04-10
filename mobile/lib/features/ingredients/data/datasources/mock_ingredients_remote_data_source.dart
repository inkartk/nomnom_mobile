import 'dart:async';

import 'package:nomnom_mobile/features/ingredients/data/dto/ingredient_dto.dart';
import 'package:nomnom_mobile/utils/date_utils.dart';

class MockIngredientsRemoteDataSource {
  final List<IngredientDto> _items = [
    IngredientDto(
      id: 'i1',
      name: 'Tomatoes',
      quantity: 3,
      unit: 'pcs',
      expirationDate: DateTime.now().add(const Duration(days: 2)),
    ),
    IngredientDto(
      id: 'i2',
      name: 'Pasta',
      quantity: 500,
      unit: 'g',
      expirationDate: DateTime.now().add(const Duration(days: 12)),
    ),
    IngredientDto(
      id: 'i3',
      name: 'Basil',
      quantity: 1,
      unit: 'bunch',
      expirationDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  Future<List<IngredientDto>> getIngredients() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.of(_items);
  }

  Future<IngredientDto> addIngredient(IngredientDto dto) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _items.add(dto);
    return dto;
  }

  Future<IngredientDto> updateIngredient(IngredientDto dto) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _items.indexWhere((e) => e.id == dto.id);
    if (index != -1) {
      _items[index] = dto;
    }
    return dto;
  }

  Future<void> deleteIngredient(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _items.removeWhere((e) => e.id == id);
  }

  Future<List<IngredientDto>> getExpiringSoon() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _items.where((e) => isExpiringSoon(e.expirationDate)).toList();
  }
}
