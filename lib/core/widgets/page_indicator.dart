import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Indicador de páginas do onboarding (dots)
class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 32 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : (isDark ? AppColors.slate800 : AppColors.slate200),
            borderRadius: BorderRadius.circular(9999),
          ),
        );
      }),
    );
  }
}
