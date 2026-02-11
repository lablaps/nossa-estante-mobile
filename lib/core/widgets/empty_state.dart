import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Widget genérico para exibir estado vazio
///
/// Centraliza o padrão de empty state com ícone, título e descrição.
/// Pode ser usado dentro de Sliver ou como widget normal.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget? action;
  final bool isSliverFillRemaining;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
    this.isSliverFillRemaining = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 96,
            color: context.isDark ? AppColors.slate600 : AppColors.slate400,
          ),
          AppSpacing.verticalLG,
          Text(
            title,
            style: AppTextStyles.h3(context).copyWith(color: context.textMuted),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSM,
          Text(
            description,
            style: AppTextStyles.bodyMedium(
              context,
            ).copyWith(color: context.textMuted),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[AppSpacing.verticalLG, action!],
        ],
      ),
    );

    if (isSliverFillRemaining) {
      return SliverFillRemaining(hasScrollBody: false, child: content);
    }

    return content;
  }
}
