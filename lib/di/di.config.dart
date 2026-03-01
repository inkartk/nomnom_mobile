// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nomnom_mobile/features/auth/data/datasources/mock_auth_remote_data_source.dart'
    as _i925;
import 'package:nomnom_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i495;
import 'package:nomnom_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i662;
import 'package:nomnom_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i54;
import 'package:nomnom_mobile/features/auth/domain/usecases/login_usecase.dart'
    as _i1021;
import 'package:nomnom_mobile/features/auth/domain/usecases/register_usecase.dart'
    as _i42;
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    as _i1005;
import 'package:nomnom_mobile/features/favorites/data/datasources/mock_favorites_remote_data_source.dart'
    as _i752;
import 'package:nomnom_mobile/features/favorites/data/repositories/favorites_repository_impl.dart'
    as _i1039;
import 'package:nomnom_mobile/features/favorites/domain/repositories/favorites_repository.dart'
    as _i487;
import 'package:nomnom_mobile/features/favorites/domain/usecases/add_favorite.dart'
    as _i545;
import 'package:nomnom_mobile/features/favorites/domain/usecases/get_favorites.dart'
    as _i134;
import 'package:nomnom_mobile/features/favorites/domain/usecases/remove_favorite.dart'
    as _i327;
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart'
    as _i305;
import 'package:nomnom_mobile/features/ingredients/data/datasources/mock_ingredients_remote_data_source.dart'
    as _i266;
import 'package:nomnom_mobile/features/ingredients/data/repositories/ingredient_repository_impl.dart'
    as _i964;
import 'package:nomnom_mobile/features/ingredients/domain/repositories/ingredient_repository.dart'
    as _i149;
import 'package:nomnom_mobile/features/ingredients/domain/usecases/add_ingredient.dart'
    as _i285;
import 'package:nomnom_mobile/features/ingredients/domain/usecases/delete_ingredient.dart'
    as _i840;
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_expiring_soon.dart'
    as _i951;
import 'package:nomnom_mobile/features/ingredients/domain/usecases/get_ingredients.dart'
    as _i631;
import 'package:nomnom_mobile/features/ingredients/domain/usecases/update_ingredient.dart'
    as _i405;
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart'
    as _i285;
import 'package:nomnom_mobile/features/recipes/data/datasources/mock_recipes_remote_data_source.dart'
    as _i977;
import 'package:nomnom_mobile/features/recipes/data/repositories/recipe_repository_impl.dart'
    as _i890;
import 'package:nomnom_mobile/features/recipes/domain/repositories/recipe_repository.dart'
    as _i459;
import 'package:nomnom_mobile/features/recipes/domain/usecases/create_recipe.dart'
    as _i83;
import 'package:nomnom_mobile/features/recipes/domain/usecases/get_recipe_details.dart'
    as _i832;
import 'package:nomnom_mobile/features/recipes/domain/usecases/get_recipes.dart'
    as _i1056;
import 'package:nomnom_mobile/features/recipes/domain/usecases/search_recipes.dart'
    as _i780;
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart'
    as _i1036;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i925.MockAuthRemoteDataSource>(
        () => _i925.MockAuthRemoteDataSource());
    gh.lazySingleton<_i977.MockRecipesRemoteDataSource>(
        () => _i977.MockRecipesRemoteDataSource());
    gh.lazySingleton<_i266.MockIngredientsRemoteDataSource>(
        () => _i266.MockIngredientsRemoteDataSource());
    gh.lazySingleton<_i149.IngredientRepository>(() =>
        _i964.IngredientRepositoryImpl(
            gh<_i266.MockIngredientsRemoteDataSource>()));
    gh.lazySingleton<_i662.AuthRepository>(
        () => _i495.AuthRepositoryImpl(gh<_i925.MockAuthRemoteDataSource>()));
    gh.lazySingleton<_i459.RecipeRepository>(() =>
        _i890.RecipeRepositoryImpl(gh<_i977.MockRecipesRemoteDataSource>()));
    gh.lazySingleton<_i752.MockFavoritesRemoteDataSource>(() =>
        _i752.MockFavoritesRemoteDataSource(
            gh<_i977.MockRecipesRemoteDataSource>()));
    gh.factory<_i951.GetExpiringSoon>(
        () => _i951.GetExpiringSoon(gh<_i149.IngredientRepository>()));
    gh.factory<_i285.AddIngredient>(
        () => _i285.AddIngredient(gh<_i149.IngredientRepository>()));
    gh.factory<_i405.UpdateIngredient>(
        () => _i405.UpdateIngredient(gh<_i149.IngredientRepository>()));
    gh.factory<_i631.GetIngredients>(
        () => _i631.GetIngredients(gh<_i149.IngredientRepository>()));
    gh.factory<_i840.DeleteIngredient>(
        () => _i840.DeleteIngredient(gh<_i149.IngredientRepository>()));
    gh.factory<_i42.RegisterUseCase>(
        () => _i42.RegisterUseCase(gh<_i662.AuthRepository>()));
    gh.factory<_i1021.LoginUseCase>(
        () => _i1021.LoginUseCase(gh<_i662.AuthRepository>()));
    gh.factory<_i54.GetMeUseCase>(
        () => _i54.GetMeUseCase(gh<_i662.AuthRepository>()));
    gh.lazySingleton<_i487.FavoritesRepository>(() =>
        _i1039.FavoritesRepositoryImpl(
            gh<_i752.MockFavoritesRemoteDataSource>()));
    gh.factory<_i134.GetFavorites>(
        () => _i134.GetFavorites(gh<_i487.FavoritesRepository>()));
    gh.factory<_i545.AddFavorite>(
        () => _i545.AddFavorite(gh<_i487.FavoritesRepository>()));
    gh.factory<_i327.RemoveFavorite>(
        () => _i327.RemoveFavorite(gh<_i487.FavoritesRepository>()));
    gh.factory<_i832.GetRecipeDetails>(
        () => _i832.GetRecipeDetails(gh<_i459.RecipeRepository>()));
    gh.factory<_i1056.GetRecipes>(
        () => _i1056.GetRecipes(gh<_i459.RecipeRepository>()));
    gh.factory<_i780.SearchRecipes>(
        () => _i780.SearchRecipes(gh<_i459.RecipeRepository>()));
    gh.factory<_i83.CreateRecipe>(
        () => _i83.CreateRecipe(gh<_i459.RecipeRepository>()));
    gh.factory<_i1005.AuthBloc>(() => _i1005.AuthBloc(
          loginUseCase: gh<_i1021.LoginUseCase>(),
          registerUseCase: gh<_i42.RegisterUseCase>(),
          getMeUseCase: gh<_i54.GetMeUseCase>(),
        ));
    gh.factory<_i285.IngredientBloc>(() => _i285.IngredientBloc(
          getIngredients: gh<_i631.GetIngredients>(),
          addIngredient: gh<_i285.AddIngredient>(),
          updateIngredient: gh<_i405.UpdateIngredient>(),
          deleteIngredient: gh<_i840.DeleteIngredient>(),
          getExpiringSoon: gh<_i951.GetExpiringSoon>(),
        ));
    gh.factory<_i1036.RecipeBloc>(() => _i1036.RecipeBloc(
          getRecipes: gh<_i1056.GetRecipes>(),
          searchRecipes: gh<_i780.SearchRecipes>(),
          getRecipeDetails: gh<_i832.GetRecipeDetails>(),
        ));
    gh.factory<_i305.FavoritesBloc>(() => _i305.FavoritesBloc(
          getFavorites: gh<_i134.GetFavorites>(),
          addFavorite: gh<_i545.AddFavorite>(),
          removeFavorite: gh<_i327.RemoveFavorite>(),
        ));
    return this;
  }
}
