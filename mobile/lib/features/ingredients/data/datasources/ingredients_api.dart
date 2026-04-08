import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nomnom_mobile/features/ingredients/data/dto/ingredient_dto.dart';

part 'ingredients_api.g.dart';

@RestApi()
abstract class IngredientsApi {
  factory IngredientsApi(Dio dio, {String baseUrl}) = _IngredientsApi;

  @POST('/api/ingredients')
  Future<IngredientDto> addIngredient(@Body() Map<String, dynamic> body);

  @GET('/api/ingredients')
  Future<List<IngredientDto>> getIngredients();

  @PUT('/api/ingredients/{id}')
  Future<IngredientDto> updateIngredient(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('/api/ingredients/{id}')
  Future<void> deleteIngredient(@Path('id') String id);

  @GET('/api/ingredients/expiring-soon')
  Future<List<IngredientDto>> getExpiringSoon();
}
