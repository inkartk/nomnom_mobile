import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';
import 'package:nomnom_mobile/widgets/state_message.dart';

@RoutePage()
class RecipeDetailsPage extends StatefulWidget {
  final String id;
  const RecipeDetailsPage({super.key, required this.id});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(LoadRecipeDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.details)),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.detailsStatus == RecipeStatus.loading) {
            return const _RecipeDetailsShimmer();
          }
          if (state.detailsStatus == RecipeStatus.error || state.selected == null) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.cloud_off_rounded,
                title: l10n.error,
                subtitle: '',
              ),
            );
          }
          final recipe = state.selected!;
          final theme = Theme.of(context);
          return AppGradientBackground(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                        alignment: Alignment.center,
                        child: Icon(Icons.image_not_supported_outlined, color: theme.colorScheme.outline),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(recipe.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(recipe.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.steps, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      ...recipe.instructions.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final step = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$index',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(step)),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favState) {
                    final isFavorite = favState.items.any((e) => e.recipe.id == recipe.id);
                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          if (isFavorite) {
                            context.read<FavoritesBloc>().add(RemoveFavoriteRequested(recipe.id));
                          } else {
                            context.read<FavoritesBloc>().add(AddFavoriteRequested(recipe.id));
                          }
                        },
                        icon: Icon(isFavorite ? Icons.bookmark_remove : Icons.bookmark_add),
                        label: Text(isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RecipeDetailsShimmer extends StatelessWidget {
  const _RecipeDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        children: [
          AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(height: 200, width: double.infinity, radius: 24),
                const SizedBox(height: 16),
                const ShimmerBox(height: 20, width: double.infinity, radius: 8),
                const SizedBox(height: 8),
                const ShimmerBox(height: 14, width: 220, radius: 8),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(height: 16, width: 120, radius: 8),
                      SizedBox(height: 12),
                      ShimmerBox(height: 12, width: double.infinity, radius: 8),
                      SizedBox(height: 8),
                      ShimmerBox(height: 12, width: double.infinity, radius: 8),
                      SizedBox(height: 8),
                      ShimmerBox(height: 12, width: 200, radius: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
