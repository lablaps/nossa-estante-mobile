import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

/// Widget que exibe chips com informações do livro
///
/// Mostra gênero, número de páginas e idioma em formato de chips.
class BookInfoChips extends StatelessWidget {
  final Book book;

  const BookInfoChips({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          // Gênero
          if (book.genres.isNotEmpty)
            _InfoChip(icon: Icons.menu_book_outlined, label: book.genres.first),

          // Número de páginas
          if (book.pageCount != null)
            _InfoChip(icon: Icons.numbers, label: '${book.pageCount} Pages'),

          // Idioma
          if (book.language != null)
            _InfoChip(icon: Icons.language, label: book.language!),

          // Condição do livro
          _InfoChip(icon: Icons.star_outline, label: book.condition.label),
        ],
      ),
    );
  }
}

/// Widget individual de chip de informação
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withValues(
                alpha: AppDimensions.opacityMediumLow,
              )
            : AppColors.primary.withValues(alpha: AppDimensions.opacityMedium),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
