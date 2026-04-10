import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';

class IngredientsShimmer extends StatelessWidget {
  const IngredientsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemBuilder: (context, index) => const IngredientShimmerCard(),
        separatorBuilder: (_, __) => AppSpacing.vMd,
        itemCount: 6,
      ),
    );
  }
}

class IngredientShimmerCard extends StatelessWidget {
  const IngredientShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: GlassCard(
        padding: AppSpacing.cardPadding,
        borderRadius: 20,
        child: Row(
          children: [
            const ShimmerBox(
              height: AppSpacing.iconCircleMd,
              width: AppSpacing.iconCircleMd,
              radius: 14,
            ),
            AppSpacing.hMd,
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 16, width: double.infinity, radius: 8),
                  SizedBox(height: 8),
                  ShimmerBox(height: 12, width: 140, radius: 8),
                  SizedBox(height: 10),
                  ShimmerBox(height: 12, width: 120, radius: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
