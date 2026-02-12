import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  static const EdgeInsets paddingPage = EdgeInsets.all(md);
  static const EdgeInsets paddingCard = EdgeInsets.all(12.0);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingForm = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets paddingBadge = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );
  static const double bottomNavPadding = 80.0;
  static const EdgeInsets paddingZero = EdgeInsets.zero;

  static const Widget verticalXS = SizedBox(height: xs);
  static const Widget verticalSM = SizedBox(height: sm);
  static const Widget verticalMD = SizedBox(height: md);
  static const Widget verticalLG = SizedBox(height: lg);
  static const Widget verticalXL = SizedBox(height: xl);
  static const Widget verticalXXL = SizedBox(height: xxl);
  static const Widget horizontalXS = SizedBox(width: xs);
  static const Widget horizontalSM = SizedBox(width: sm);
  static const Widget horizontalMD = SizedBox(width: md);
  static const Widget horizontalLG = SizedBox(width: lg);
  static const Widget horizontalXL = SizedBox(width: xl);
}
