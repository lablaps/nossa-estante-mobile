import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CreditBadge extends StatelessWidget {
  final int credits;
  final VoidCallback? onTap;

  const CreditBadge({super.key, required this.credits, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = context.isDark ? AppColors.primary : AppColors.primaryDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingBadge,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(AppDimensions.opacityLow),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(AppDimensions.opacityMedium),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.token, color: color, size: 18),
            AppSpacing.horizontalXS,
            Text(
              '$credits ${credits == 1 ? 'Crédito' : 'Créditos'}',
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
