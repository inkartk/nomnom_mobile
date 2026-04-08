import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';
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
            return const _FavoritesShimmer();
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
                SliverToBoxAdapter(
                  child: _FavoritesHeader(
                    title: l10n.favorites,
                    subtitle: l10n.addToFavorites,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return _FavoriteCard(
                        item: item,
                        onRemove: () => context.read<FavoritesBloc>().add(RemoveFavoriteRequested(item.recipe.id)),
                        onTap: () => context.router.push(RecipeDetailsRoute(id: item.recipe.id)),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
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

class _FavoritesHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FavoritesHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 88, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withOpacity(0.18),
              colorScheme.secondary.withOpacity(0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_rounded,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final FavoriteRecipe item;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const _FavoriteCard({
    required this.item,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _RecipeImage(url: item.recipe.imageUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.recipe.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          context.l10n.favorites,
                          style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.primary),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          color: theme.hintColor,
                          onPressed: onRemove,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String url;

  const _RecipeImage({required this.url});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 88,
        height: 88,
        color: colorScheme.surfaceVariant.withOpacity(0.4),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          },
          errorBuilder: (_, __, ___) => Icon(
            Icons.image_not_supported_outlined,
            color: colorScheme.outline,
          ),
        ),
      ),
    );
  }
}


class _FavoritesShimmer extends StatelessWidget {
  const _FavoritesShimmer();

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        itemBuilder: (context, index) => const _ShimmerCard(),
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemCount: 6,
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            const ShimmerBox(height: 88, width: 88, radius: 18),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(height: 16, width: double.infinity, radius: 8),
                  const SizedBox(height: 10),
                  const ShimmerBox(height: 12, width: double.infinity, radius: 8),
                  const SizedBox(height: 8),
                  const ShimmerBox(height: 12, width: 140, radius: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
