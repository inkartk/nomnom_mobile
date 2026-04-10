import 'dart:async';

import 'package:nomnom_mobile/features/recipes/data/dto/recipe_dto.dart';

class MockRecipesRemoteDataSource {
  final List<RecipeDto> _recipes = [
    const RecipeDto(
      id: 'r1',
      title: 'Tomato Basil Pasta',
      description: 'Quick pasta with fresh tomatoes and basil.',
      instructions: ['Boil pasta', 'Saute tomatoes', 'Mix with basil and olive oil'],
      imageUrl: 'https://images.unsplash.com/photo-1523986371872-9d3ba2e2a389',
    ),
    const RecipeDto(
      id: 'r2',
      title: 'Avocado Toast Deluxe',
      description: 'Crispy toast with avocado and lemon zest.',
      instructions: ['Toast bread', 'Mash avocado', 'Season and serve'],
      imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141',
    ),
    const RecipeDto(
      id: 'r3',
      title: 'Lemon Herb Salad',
      description: 'Bright salad with herbs and citrus.',
      instructions: ['Chop greens', 'Mix dressing', 'Toss and enjoy'],
      imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352',
    ),
  ];

  Future<List<RecipeDto>> getRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.of(_recipes);
  }

  Future<List<RecipeDto>> searchRecipes(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) return getRecipes();
    final lower = query.toLowerCase();
    return _recipes.where((r) => r.title.toLowerCase().contains(lower)).toList();
  }

  Future<RecipeDto> getRecipeDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _recipes.firstWhere((r) => r.id == id);
  }

  Future<RecipeDto> createRecipe(RecipeDto dto) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _recipes.add(dto);
    return dto;
  }
}
