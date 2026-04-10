import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';

class IngredientsHeader extends StatelessWidget {
  final String title;
  final bool filterActive;
  final VoidCallback onToggle;

  const IngredientsHeader({
    super.key,
    required this.title,
    required this.filterActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Padding(
      padding: AppSpacing.sectionPadding,
      child: GlassCard(
        padding: AppSpacing.sectionCardPadding,
        child: Row(
          children: [
            Container(
              height: AppSpacing.iconCircleMd,
              width: AppSpacing.iconCircleMd,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: AppColors.accentGradient,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Icon(Icons.kitchen, color: Colors.white),
            ),
            AppSpacing.hMd,
            Expanded(
              child: Text(title, style: theme.textTheme.headlineSmall),
            ),
            FilterChip(
              selected: filterActive,
              onSelected: (_) => onToggle(),
              label: Text(l10n.expiringSoon),
              selectedColor: AppColors.accentGold.withValues(alpha: 0.2),
              checkmarkColor: AppColors.accentGold,
            ),
          ],
        ),
      ),
    );
  }
}
