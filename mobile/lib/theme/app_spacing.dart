import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Common EdgeInsets
  static const pagePadding = EdgeInsets.all(lg);
  static const pageHorizontal = EdgeInsets.symmetric(horizontal: lg);
  static const cardPadding = EdgeInsets.all(md);
  static const cardPaddingLarge = EdgeInsets.all(lg);
  static const cardPaddingCompact = EdgeInsets.all(14);
  static const inputPadding = EdgeInsets.symmetric(horizontal: md, vertical: 14);
  static const listPadding = EdgeInsets.fromLTRB(md, sm, md, lg);
  static const sectionPadding = EdgeInsets.fromLTRB(md, md, md, 12);
  static const sectionCardPadding = EdgeInsets.all(18);
  static const badgePadding = EdgeInsets.symmetric(horizontal: 10, vertical: xs);

  // Common SizedBoxes
  static const vXs = SizedBox(height: xs);
  static const vSm = SizedBox(height: sm);
  static const vMd = SizedBox(height: md);
  static const vLg = SizedBox(height: lg);
  static const vXl = SizedBox(height: xl);

  static const hXs = SizedBox(width: xs);
  static const hSm = SizedBox(width: sm);
  static const hMd = SizedBox(width: md);
  static const hLg = SizedBox(width: lg);

  // Border Radius
  static final radiusSm = BorderRadius.circular(sm);
  static final radiusMd = BorderRadius.circular(md);
  static final radiusLg = BorderRadius.circular(lg);
  static final radiusXl = BorderRadius.circular(xl);
  static final radiusCard = BorderRadius.circular(22);
  static final radiusCardMd = BorderRadius.circular(20);

  // Icon sizes
  static const double iconCircleLg = 54;
  static const double iconCircleMd = 50;
  static const double thumbnailSize = 80;
  static const double avatarSize = 56;
  static const double stepNumberSize = 28;
}
