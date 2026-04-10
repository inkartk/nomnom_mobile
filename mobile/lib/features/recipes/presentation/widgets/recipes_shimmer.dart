import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';

class RecipesShimmer extends StatelessWidget {
  const RecipesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemBuilder: (context, index) => const RecipeShimmerCard(),
        separatorBuilder: (_, __) => AppSpacing.vMd,
        itemCount: 6,
      ),
    );
  }
}

class RecipeShimmerCard extends StatelessWidget {
  const RecipeShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: GlassCard(
        padding: EdgeInsets.zero,
        borderRadius: 22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(height: 160, width: double.infinity, radius: 22),
            Padding(
              padding: AppSpacing.cardPadding,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 16, width: double.infinity, radius: 8),
                  SizedBox(height: 8),
                  ShimmerBox(height: 12, width: 180, radius: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
