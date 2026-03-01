import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nomnom_mobile/features/recipes/data/dto/recipe_dto.dart';

part 'recipes_api.g.dart';

@RestApi()
abstract class RecipesApi {
  factory RecipesApi(Dio dio, {String baseUrl}) = _RecipesApi;

  @POST('/api/recipes')
  Future<RecipeDto> createRecipe(@Body() Map<String, dynamic> body);

  @GET('/api/recipes/search')
  Future<List<RecipeDto>> searchRecipes(@Query('query') String query);

  @GET('/api/recipes/{id}')
  Future<RecipeDto> getRecipeDetails(@Path('id') String id);
}
