import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

/// Widget de badge de status do livro
///
/// Exibe o status atual do livro (disponível, em troca ou indisponível)
/// com cores e ícones apropriados.
class BookStatusBadge extends StatelessWidget {
  final BookStatus status;

  const BookStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final badgeData = _getBadgeData(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeData.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeData.icon, size: 16, color: badgeData.textColor),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: AppTextStyles.caption(context).copyWith(
              color: badgeData.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeData _getBadgeData(BookStatus status) {
    switch (status) {
      case BookStatus.available:
        return _BadgeData(
          backgroundColor: AppColors.statusAvailable.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
          textColor: const Color(0xFF059669), // emerald-600
          icon: Icons.check_circle_outline,
        );
      case BookStatus.inExchange:
        return _BadgeData(
          backgroundColor: AppColors.statusInExchange.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
          textColor: const Color(0xFFD97706), // amber-600
          icon: Icons.sync_outlined,
        );
      case BookStatus.unavailable:
        return _BadgeData(
          backgroundColor: AppColors.statusUnavailable.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
          textColor: const Color(0xFF4B5563), // gray-600
          icon: Icons.schedule_outlined,
        );
    }
  }
}

/// Dados de configuração do badge
class _BadgeData {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  _BadgeData({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}
