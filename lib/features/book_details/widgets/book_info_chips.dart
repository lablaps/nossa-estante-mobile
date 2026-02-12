import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

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
            _InfoChip(icon: Icons.numbers, label: '${book.pageCount} páginas'),

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
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.emerald900.withValues(alpha: 0.3)
            : AppColors.emerald100,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? AppColors.emerald300 : AppColors.emerald800,
          ),
          const SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.bodyMedium(context).copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 12,
              color: isDark ? AppColors.emerald100 : AppColors.emerald900,
            ),
          ),
        ],
      ),
    );
  }
}
