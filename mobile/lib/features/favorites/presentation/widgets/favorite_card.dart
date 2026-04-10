import 'package:flutter/material.dart';
import 'package:nomnom_mobile/features/favorites/domain/entities/favorite_recipe.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/recipe_image.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteRecipe item;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: AppSpacing.cardPaddingCompact,
      borderRadius: 22,
      child: InkWell(
        borderRadius: AppSpacing.radiusCard,
        onTap: onTap,
        child: Row(
          children: [
            RecipeImage(url: item.recipe.imageUrl),
            AppSpacing.hMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  AppSpacing.vXs,
                  Text(
                    item.recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  AppSpacing.vSm,
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      AppSpacing.hXs,
                      Text(
                        context.l10n.favorites,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded),
                        color: AppColors.textTertiary,
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
    );
  }
}
