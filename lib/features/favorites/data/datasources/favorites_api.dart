import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nomnom_mobile/features/favorites/data/dto/favorite_recipe_dto.dart';

part 'favorites_api.g.dart';

@RestApi()
abstract class FavoritesApi {
  factory FavoritesApi(Dio dio, {String baseUrl}) = _FavoritesApi;

  @POST('/api/favorites/{recipeId}')
  Future<void> addFavorite(@Path('recipeId') String recipeId);

  @GET('/api/favorites')
  Future<List<FavoriteRecipeDto>> getFavorites();

  @DELETE('/api/favorites/{recipeId}')
  Future<void> removeFavorite(@Path('recipeId') String recipeId);
}
