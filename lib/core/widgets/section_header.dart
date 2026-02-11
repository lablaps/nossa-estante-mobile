import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Header de seção reutilizável
///
/// Exibe um título com ícone opcional e botão "Ver todos" opcional.
/// Não contém lógica de navegação - usa callback [onViewAll].
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? viewAllText;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.viewAllText,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: AppTextStyles.h3(context)),
              if (icon != null) ...[
                AppSpacing.horizontalSM,
                Icon(icon, color: AppColors.primary, size: 20),
              ],
            ],
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                viewAllText ?? 'Ver todos',
                style: AppTextStyles.labelLarge(
                  context,
                ).copyWith(color: context.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
