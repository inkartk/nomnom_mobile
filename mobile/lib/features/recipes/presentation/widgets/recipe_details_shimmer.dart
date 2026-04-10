import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';

class RecipeDetailsShimmer extends StatelessWidget {
  const RecipeDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(
                    height: 200, width: double.infinity, radius: 24),
                AppSpacing.vMd,
                const ShimmerBox(
                    height: 20, width: double.infinity, radius: 8),
                AppSpacing.vSm,
                const ShimmerBox(height: 14, width: 220, radius: 8),
                AppSpacing.vMd,
                GlassCard(
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(height: 16, width: 120, radius: 8),
                      SizedBox(height: 12),
                      ShimmerBox(
                          height: 12, width: double.infinity, radius: 8),
                      SizedBox(height: 8),
                      ShimmerBox(
                          height: 12, width: double.infinity, radius: 8),
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
