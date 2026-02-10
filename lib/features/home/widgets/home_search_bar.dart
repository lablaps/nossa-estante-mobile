import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../home_controller.dart';

/// Barra de busca com filtros da home
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingPage.copyWith(
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Column(
        children: [
          // Search input
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
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4),
                  child: Icon(Icons.search, color: context.textMuted),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar livros, autores ou gêneros',
                      hintStyle: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: context.textMuted.withOpacity(0.7)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4),
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

          // Filter chips
          Consumer<HomeController>(
            builder: (context, controller, _) {
              return SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.filters.length,
                  separatorBuilder: (_, __) => AppSpacing.horizontalSM,
                  itemBuilder: (context, index) {
                    final filter = controller.filters[index];
                    final isSelected = controller.selectedFilter == filter;

                    return GestureDetector(
                      onTap: () => controller.setFilter(filter),
                      child: Container(
                        padding: EdgeInsets.symmetric(
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
                                ? Colors.transparent
                                : context.borderColor,
                          ),
                        ),
                        child: Text(
                          filter,
                          style: AppTextStyles.labelMedium(context).copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.black
                                : context.textMuted,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
