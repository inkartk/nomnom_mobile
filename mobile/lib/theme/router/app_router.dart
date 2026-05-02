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
import 'package:nomnom_mobile/features/auth/presentation/pages/verify_email_pending_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: LoginRoute.page,
          path: '/login',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 350,
        ),
        CustomRoute(
          page: RegisterRoute.page,
          path: '/register',
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: VerifyEmailPendingRoute.page,
          path: '/verify-email-pending',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: HomeRoute.page,
          path: '/home',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 350,
          children: [
            AutoRoute(
                page: IngredientsRoute.page,
                path: 'ingredients',
                initial: true),
            AutoRoute(page: RecipesRoute.page, path: 'recipes'),
            AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        ),
        CustomRoute(
          page: RecipeDetailsRoute.page,
          path: '/recipe/:id',
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 350,
        ),
        CustomRoute(
          page: IngredientFormRoute.page,
          path: '/ingredient-form',
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 300,
        ),
      ];
}
