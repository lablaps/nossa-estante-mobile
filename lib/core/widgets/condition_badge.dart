import 'package:flutter/material.dart';
import '../domain/entities/entities.dart';
import '../theme/theme.dart';

/// Badge para exibir a condição de um livro
///
/// Exibe a condição do livro com estilo consistente.
class ConditionBadge extends StatelessWidget {
  final BookCondition condition;
  final double? fontSize;
  final EdgeInsets? padding;

  const ConditionBadge({
    super.key,
    required this.condition,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.slate800.withOpacity(0.5)
            : AppColors.slate200,
        borderRadius: AppDimensions.borderRadiusSM,
        border: Border.all(
          color: context.isDark ? AppColors.slate600 : AppColors.slate200,
          width: 1,
        ),
      ),
      child: Text(
        condition.label,
        style: AppTextStyles.caption(context).copyWith(
          color: context.textMuted,
          fontSize: fontSize ?? 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
