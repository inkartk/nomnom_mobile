import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/di/di.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:talker_flutter/talker_flutter.dart';

class NomNomApp extends StatelessWidget {
  NomNomApp({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(const AuthStarted())),
        BlocProvider(create: (_) => getIt<IngredientBloc>()..add(const LoadIngredients())),
        BlocProvider(create: (_) => getIt<RecipeBloc>()..add(const LoadRecipes())),
        BlocProvider(create: (_) => getIt<FavoritesBloc>()..add(const LoadFavorites())),
      ],
      child: TalkerWrapper(
        talker: appTalker,
        child: MaterialApp.router(
          title: 'NomNom',
          theme: AppTheme.light(),
          routerConfig: _router.config(
            navigatorObservers: () => [TalkerRouteObserver(appTalker)],
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ru')],
        ),
      ),
    );
  }
}
