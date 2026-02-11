import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Barra de busca da página Explorar
///
/// Exibe um campo de busca com ícone.
/// Não contém lógica de navegação ou busca.
class ExploreSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const ExploreSearchBar({super.key, this.onTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingHorizontal,
      margin: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 6,
          ),
          decoration: BoxDecoration(
            color: context.isDark ? AppColors.surfaceDark : AppColors.white,
            borderRadius: AppDimensions.borderRadiusLG,
            border: Border.all(
              color: context.isDark
                  ? AppColors.borderDark
                  : AppColors.borderLight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: context.isDark ? AppColors.slate400 : AppColors.slate600,
                size: AppDimensions.iconMD,
              ),
              AppSpacing.horizontalMD,
              Expanded(
                child: Text(
                  'Buscar por título, autor ou gênero',
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: context.isDark
                        ? AppColors.slate400
                        : AppColors.slate600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
