import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Item de filtro para FilterChips
class FilterItem<T> {
  final T value;
  final String label;

  const FilterItem({required this.value, required this.label});
}

/// Widget genérico para exibir chips de filtro horizontais
///
/// Componente reutilizável para qualquer tipo de filtro.
/// Aceita uma lista de itens genéricos e callback de seleção.
class FilterChips<T> extends StatelessWidget {
  final List<FilterItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onFilterSelected;
  final double height;
  final EdgeInsets? padding;

  const FilterChips({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onFilterSelected,
    this.height = 36,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item.value == selectedValue;

          return _FilterChip(
            label: item.label,
            isSelected: isSelected,
            onTap: () => onFilterSelected(item.value),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (context.isDark ? AppColors.primary : AppColors.slate900)
              : (context.isDark ? AppColors.slate800 : AppColors.white),
          borderRadius: AppDimensions.borderRadiusFull,
          border: isSelected
              ? null
              : Border.all(
                  color: context.isDark
                      ? AppColors.slate600
                      : AppColors.slate200,
                  width: 1,
                ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption(context).copyWith(
            color: isSelected
                ? (context.isDark ? AppColors.slate900 : AppColors.white)
                : context.textMuted,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
