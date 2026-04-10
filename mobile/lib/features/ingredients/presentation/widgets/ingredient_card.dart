import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/date_utils.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient item;
  const IngredientCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final soon = isExpiringSoon(item.expirationDate);
    final days = daysUntil(item.expirationDate);
    final theme = Theme.of(context);
    return GlassCard(
      padding: AppSpacing.cardPadding,
      borderRadius: 20,
      child: InkWell(
        borderRadius: AppSpacing.radiusCardMd,
        onTap: () =>
            context.router.push(IngredientFormRoute(ingredientId: item.id)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppSpacing.iconCircleMd,
              height: AppSpacing.iconCircleMd,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: soon
                      ? [
                          AppColors.accentGold.withValues(alpha: 0.3),
                          AppColors.accentGold.withValues(alpha: 0.15),
                        ]
                      : [
                          AppColors.success.withValues(alpha: 0.3),
                          AppColors.success.withValues(alpha: 0.15),
                        ],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                soon ? Icons.timer : Icons.check_circle,
                color: soon ? AppColors.accentGold : AppColors.success,
              ),
            ),
            AppSpacing.hMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textTheme.titleMedium),
                  AppSpacing.vXs,
                  Text(
                    '${item.quantity} ${item.unit}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppSpacing.vSm,
                  Container(
                    padding: AppSpacing.badgePadding,
                    decoration: BoxDecoration(
                      color: soon
                          ? AppColors.accentGold.withValues(alpha: 0.15)
                          : AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      l10n.expiresInDays(days),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: soon ? AppColors.accentGold : AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  context.router
                      .push(IngredientFormRoute(ingredientId: item.id));
                } else if (value == 'delete') {
                  context
                      .read<IngredientBloc>()
                      .add(DeleteIngredientRequested(item.id));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                PopupMenuItem(value: 'delete', child: Text(l10n.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
