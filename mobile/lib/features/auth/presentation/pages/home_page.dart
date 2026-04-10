import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/custom_bottom_nav.dart';

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
        return CustomBottomNav(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            NavItem(
              icon: Icons.kitchen_outlined,
              activeIcon: Icons.kitchen,
              label: l10n.ingredients,
            ),
            NavItem(
              icon: Icons.menu_book_outlined,
              activeIcon: Icons.menu_book,
              label: l10n.recipes,
            ),
            NavItem(
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite,
              label: l10n.favorites,
            ),
            NavItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: l10n.profile,
            ),
          ],
        );
      },
    );
  }
}
