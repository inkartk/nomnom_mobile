import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/widgets/recipe_details_shimmer.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/gradient_button.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.details)),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.detailsStatus == RecipeStatus.loading) {
            return const RecipeDetailsShimmer();
          }
          if (state.detailsStatus == RecipeStatus.error ||
              state.selected == null) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.cloud_off_rounded,
                title: l10n.error,
                subtitle: '',
              ),
            );
          }
          final recipe = state.selected!;
          return AppGradientBackground(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                ClipRRect(
                  borderRadius: AppSpacing.radiusLg,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Hero(
                      tag: 'recipe-image-${recipe.id}',
                      child: Image.network(
                        recipe.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.surface,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.accent,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surface,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacing.vMd,
                Text(recipe.title, style: theme.textTheme.headlineSmall),
                AppSpacing.vSm,
                Text(
                  recipe.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                AppSpacing.vMd,
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.steps, style: theme.textTheme.titleMedium),
                      AppSpacing.vMd,
                      ...recipe.instructions.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final step = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: AppSpacing.stepNumberSize,
                                height: AppSpacing.stepNumberSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: AppColors.accentGradient,
                                  ),
                                  borderRadius: AppSpacing.radiusSm,
                                ),
                                child: Text(
                                  '$index',
                                  style:
                                      theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              AppSpacing.hMd,
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(step),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                AppSpacing.vMd,
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favState) {
                    final isFavorite =
                        favState.items.any((e) => e.recipe.id == recipe.id);
                    return SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        onPressed: () {
                          if (isFavorite) {
                            context
                                .read<FavoritesBloc>()
                                .add(RemoveFavoriteRequested(recipe.id));
                          } else {
                            context
                                .read<FavoritesBloc>()
                                .add(AddFavoriteRequested(recipe.id));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isFavorite
                                ? Icons.bookmark_remove
                                : Icons.bookmark_add),
                            AppSpacing.hSm,
                            Text(isFavorite
                                ? l10n.removeFromFavorites
                                : l10n.addToFavorites),
                          ],
                        ),
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
