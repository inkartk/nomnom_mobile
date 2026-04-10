import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const background = Color(0xFF0D0D0F);
  static const backgroundSecondary = Color(0xFF1A1A2E);

  // Surfaces
  static const surface = Color(0xFF16213E);
  static const surfaceLight = Color(0xFF1E2A4A);

  // Accents
  static const accent = Color(0xFFFF6B6B);
  static const accentDark = Color(0xFFFF8E53);
  static const accentSecondary = Color(0xFF4ECDC4);
  static const accentGold = Color(0xFFFFD93D);

  // Text
  static const textPrimary = Color(0xFFF0F0F5);
  static const textSecondary = Color(0xFF8B8FA3);
  static const textTertiary = Color(0xFF5A5E72);

  // Glass
  static final glassBorder = Colors.white.withValues(alpha: 0.10);
  static final glassFill = Colors.white.withValues(alpha: 0.06);

  // Status
  static const error = Color(0xFFFF4757);
  static const success = Color(0xFF2ED573);

  // Shimmer
  static const shimmerBase = Color(0xFF1E2A4A);
  static const shimmerHighlight = Color(0xFF2A3A5E);

  // Gradients
  static const pageGradient = [background, backgroundSecondary];
  static const accentGradient = [accent, accentDark];
  static const accentGradientWithOpacity = [
    Color(0x14FF6B6B),
    Color(0x0DFF8E53),
  ];
}
