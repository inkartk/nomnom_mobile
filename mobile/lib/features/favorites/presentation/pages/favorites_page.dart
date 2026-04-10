import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/widgets/favorite_card.dart';
import 'package:nomnom_mobile/features/favorites/presentation/widgets/favorites_shimmer.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/animated_list_item.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/state_message.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.favorites)),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status == FavoritesStatus.loading) {
            return const FavoritesShimmer();
          }
          if (state.status == FavoritesStatus.error) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.cloud_off_rounded,
                title: l10n.error,
                subtitle: state.errorMessage ?? '',
              ),
            );
          }
          if (state.items.isEmpty) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.favorite_border_rounded,
                title: l10n.noData,
                subtitle: l10n.addToFavorites,
              ),
            );
          }
          return AppGradientBackground(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: AppSpacing.listPadding,
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return AnimatedListItem(
                        index: index,
                        child: FavoriteCard(
                          item: item,
                          onRemove: () => context
                              .read<FavoritesBloc>()
                              .add(RemoveFavoriteRequested(item.recipe.id)),
                          onTap: () => context.router
                              .push(RecipeDetailsRoute(id: item.recipe.id)),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => AppSpacing.vMd,
                    itemCount: state.items.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
