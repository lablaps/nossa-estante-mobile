import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Chips de filtro de gênero
///
/// Exibe uma lista horizontal de chips para filtrar por gênero.
/// Não contém lógica de domínio - usa callback [onGenreSelected].
class GenreFilterChips extends StatelessWidget {
  final List<String> genres;
  final String selectedGenre;
  final ValueChanged<String> onGenreSelected;

  const GenreFilterChips({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.paddingHorizontal,
        itemCount: genres.length,
        separatorBuilder: (context, index) => AppSpacing.horizontalSM,
        itemBuilder: (context, index) {
          final genre = genres[index];
          final isSelected = genre == selectedGenre;

          return _GenreChip(
            label: genre,
            isSelected: isSelected,
            onTap: () => onGenreSelected(genre),
          );
        },
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenreChip({
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
          horizontal: AppSpacing.md + 4,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (context.isDark ? AppColors.surfaceDark : AppColors.white),
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryDark
                : (context.isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.labelLarge(context).copyWith(
            color: isSelected
                ? AppColors.white
                : (context.isDark
                      ? AppColors.textMutedLight
                      : AppColors.slate600),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
