import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';

class RecipesHeader extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onSearch;

  const RecipesHeader({
    super.key,
    required this.title,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Padding(
      padding: AppSpacing.sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
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
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                  ),
                ),
                AppSpacing.hMd,
                Expanded(
                  child: Text(title, style: theme.textTheme.headlineSmall),
                ),
              ],
            ),
          ),
          AppSpacing.vMd,
          GlassCard(
            padding: const EdgeInsets.all(12),
            borderRadius: 20,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: l10n.searchRecipes,
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (_) => onSearch(),
            ),
          ),
        ],
      ),
    );
  }
}
