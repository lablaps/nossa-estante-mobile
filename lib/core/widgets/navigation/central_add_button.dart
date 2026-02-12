import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class CentralAddButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final IconData? icon;
  final String? label;

  const CentralAddButton({
    super.key,
    required this.isActive,
    required this.onTap,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(
                      alpha: AppDimensions.opacityMedium,
                    ),
                    blurRadius: AppDimensions.elevationVeryHigh,
                    offset: Offset(0, AppSpacing.xs),
                  ),
                ],
              ),
              child: Icon(icon ?? Icons.add, color: AppColors.white, size: 28),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -16),
            child: Text(
              label ?? 'Adicionar',
              style: AppTextStyles.caption(
                context,
              ).copyWith(fontWeight: FontWeight.w500, color: context.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
