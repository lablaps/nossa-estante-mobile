import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class HomeSearchBar extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String>? onFilterSelected;

  const HomeSearchBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingPage.copyWith(
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Column(
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: context.inputBackground,
              borderRadius: AppDimensions.borderRadiusMD,
              border: Border.all(color: context.borderColor),
              boxShadow: [
                BoxShadow(
                  color: context.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: Icon(Icons.search, color: context.textMuted),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar livros, autores ou gêneros',
                      hintStyle: AppTextStyles.bodyMedium(context).copyWith(
                        color: context.textMuted.withOpacity(
                          AppDimensions.opacityHigh + 0.1,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: AppSpacing.paddingZero,
                    ),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: context.borderColor),
                    ),
                  ),
                  child: Icon(Icons.tune, color: context.primaryColor),
                ),
              ],
            ),
          ),
          AppSpacing.verticalSM,
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => AppSpacing.horizontalSM,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return GestureDetector(
                  onTap: onFilterSelected != null
                      ? () => onFilterSelected!(filter)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : context.surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.transparent
                            : context.borderColor,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: AppTextStyles.labelMedium(context).copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected ? AppColors.black : context.textMuted,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
