import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/di/di.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:nomnom_mobile/theme/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_theme.dart';
import 'package:nomnom_mobile/localization/app_localizations.dart';
import 'package:talker_flutter/talker_flutter.dart' show TalkerRouteObserver;

class NomNomApp extends StatelessWidget {
  NomNomApp({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(const AuthStarted())),
        BlocProvider(create: (_) => getIt<IngredientBloc>()),
        BlocProvider(create: (_) => getIt<RecipeBloc>()..add(const LoadRecipes())),
        BlocProvider(create: (_) => getIt<FavoritesBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (prev, curr) =>
                  prev.status != curr.status &&
                  curr.status == AuthStatus.unauthenticated,
              listener: (context, state) {
                context.read<IngredientBloc>().add(const ResetIngredients());
                _router.replaceAll([const LoginRoute()]);
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (prev, curr) =>
                  curr.status == AuthStatus.authenticated &&
                  (prev.status != AuthStatus.authenticated ||
                      prev.user?.id != curr.user?.id),
              listener: (context, state) {
                context.read<IngredientBloc>().add(const ResetIngredients());
                context.read<IngredientBloc>().add(const LoadIngredients());
                context.read<FavoritesBloc>().add(const LoadFavorites());
              },
            ),
          ],
          child: MaterialApp.router(
          title: 'NomNom',
          theme: AppTheme.dark(),
          routerConfig: _router.config(
            navigatorObservers: () => [TalkerRouteObserver(appTalker)],
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
        ),
      ),
    );
  }
}

