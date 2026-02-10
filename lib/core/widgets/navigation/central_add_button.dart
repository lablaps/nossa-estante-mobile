import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Botão central elevado de adicionar para bottom navigation bar

class CentralAddButton extends StatelessWidget {
  /// Se o botão está ativo/selecionado
  final bool isActive;

  /// Callback ao tocar no botão
  final VoidCallback onTap;

  const CentralAddButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -12),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(
                      AppDimensions.opacityMediumHigh,
                    ),
                    blurRadius: AppDimensions.elevationVeryHigh,
                    offset: Offset(0, AppSpacing.xs),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: AppColors.white, size: 28),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -8),
            child: Text(
              'Adicionar',
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
