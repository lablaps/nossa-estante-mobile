import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/theme_extensions.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: isActive ? 32 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : (context.isDark ? AppColors.slate800 : AppColors.slate200),
            borderRadius: BorderRadius.circular(9999),
          ),
        );
      }),
    );
  }
}
