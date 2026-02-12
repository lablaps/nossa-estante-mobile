import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDimensions {
  AppDimensions._();

  static const double radiusXS = 8.0;
  static const double radiusSM = 12.0;
  static const double radiusMD = 16.0;
  static const double radiusLG = 24.0;
  static const double radiusXL = 28.0;
  static const double radiusFull = 9999.0;

  static final BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);
  static final BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);
  static final BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);
  static final BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(
    radiusFull,
  );

  static const double buttonHeight = 56.0;
  static const double inputHeight = 56.0;
  static const double buttonCircularSmall = 48.0;
  static const double buttonCircularMedium = 56.0;
  static const double buttonCircularLarge = 64.0;
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 40.0;
  static const double avatarLarge = 96.0;
  static const double maxContentWidth = 600.0;

  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 28.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 48.0;

  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;

  static const double borderThin = 1.0;
  static const double borderMedium = 1.5;
  static const double borderThick = 2.0;

  static const double opacityVeryLow = 0.05;
  static const double opacityLow = 0.1;
  static const double opacityMediumLow = 0.2;
  static const double opacityMedium = 0.3;
  static const double opacityMediumHigh = 0.5;
  static const double opacityHigh = 0.6;
  static const double opacityVeryHigh = 0.9;

  static final List<BoxShadow> shadowCard = [
    BoxShadow(
      color: AppColors.overlayLight,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> shadowButton = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> shadowFloating = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> shadowElevated = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 20,
      offset: const Offset(0, -5),
    ),
  ];

  static List<BoxShadow> shadowGlow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: opacityMedium),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}
