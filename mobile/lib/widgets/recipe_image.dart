import 'package:flutter/material.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';

class RecipeImage extends StatelessWidget {
  final String url;
  final double size;

  const RecipeImage({
    super.key,
    required this.url,
    this.size = AppSpacing.thumbnailSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppSpacing.radiusMd,
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          url,
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
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
