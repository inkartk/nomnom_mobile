import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/utils/l10n.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AutoTabsScaffold(
      routes: const [
        IngredientsRoute(),
        RecipesRoute(),
        FavoritesRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(icon: const Icon(Icons.kitchen), label: l10n.ingredients),
            NavigationDestination(icon: const Icon(Icons.search), label: l10n.recipes),
            NavigationDestination(icon: const Icon(Icons.bookmark), label: l10n.favorites),
            NavigationDestination(icon: const Icon(Icons.person), label: l10n.profile),
          ],
        );
      },
    );
  }
}
