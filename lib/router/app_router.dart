import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:nomnom_mobile/features/auth/presentation/pages/register_page.dart';
import 'package:nomnom_mobile/features/favorites/presentation/pages/favorites_page.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/pages/ingredient_form_page.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/pages/ingredients_page.dart';
import 'package:nomnom_mobile/features/recipes/presentation/pages/recipe_details_page.dart';
import 'package:nomnom_mobile/features/recipes/presentation/pages/recipes_page.dart';
import 'package:nomnom_mobile/features/auth/presentation/pages/splash_page.dart';
import 'package:nomnom_mobile/features/auth/presentation/pages/home_page.dart';
import 'package:nomnom_mobile/features/auth/presentation/pages/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          children: [
            AutoRoute(page: IngredientsRoute.page, path: 'ingredients', initial: true),
            AutoRoute(page: RecipesRoute.page, path: 'recipes'),
            AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        ),
        AutoRoute(page: RecipeDetailsRoute.page, path: '/recipe/:id'),
        AutoRoute(page: IngredientFormRoute.page, path: '/ingredient-form'),
      ];
}
