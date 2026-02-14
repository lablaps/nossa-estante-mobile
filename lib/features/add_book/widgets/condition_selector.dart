import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

class ConditionSelector extends StatelessWidget {
  final BookCondition selectedCondition;
  final void Function(BookCondition) onConditionChanged;

  const ConditionSelector({
    super.key,
    required this.selectedCondition,
    required this.onConditionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Condição',
          style: AppTextStyles.labelMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.verticalSM,

        // Condition buttons
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border.all(color: context.borderColor),
            borderRadius: AppDimensions.borderRadiusSM,
          ),
          child: Row(
            children: [
              _buildConditionButton(context, BookCondition.new_, 'Novo'),
              _buildConditionButton(
                context,
                BookCondition.likeNew,
                'Muito Bom',
              ),
              _buildConditionButton(context, BookCondition.good, 'Bom'),
              _buildConditionButton(context, BookCondition.fair, 'Usado'),
            ],
          ),
        ),
        AppSpacing.verticalSM,

        // Description
        Text(
          _getConditionDescription(selectedCondition),
          style: AppTextStyles.caption(
            context,
          ).copyWith(color: context.textMuted),
        ),
      ],
    );
  }

  Widget _buildConditionButton(
    BuildContext context,
    BookCondition condition,
    String label,
  ) {
    final isSelected = selectedCondition == condition;

    return Expanded(
      child: GestureDetector(
        onTap: () => onConditionChanged(condition),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            borderRadius: AppDimensions.borderRadiusSM,
            boxShadow: isSelected ? AppDimensions.shadowCard : null,
          ),
          child: Text(
            label,
            style: AppTextStyles.caption(context).copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.black : context.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _getConditionDescription(BookCondition condition) {
    switch (condition) {
      case BookCondition.new_:
        return 'Novo, sem uso, em perfeitas condições.';
      case BookCondition.likeNew:
        return 'Sinais mínimos de uso, excelente estado.';
      case BookCondition.good:
        return 'Usado, mas bem conservado com desgaste mínimo.';
      case BookCondition.fair:
        return 'Desgaste visível, mas completamente legível.';
    }
  }
}
