import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

/// Widget que exibe as informações principais do livro
///
/// Inclui título, autor e ISBN (se disponível).
class BookInfoSection extends StatelessWidget {
  final Book book;

  const BookInfoSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Text(
          book.title,
          style: AppTextStyles.h1(
            context,
          ).copyWith(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        AppSpacing.verticalSM,

        // Autor
        Row(
          children: [
            Icon(Icons.person_outline, size: 18, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              book.author,
              style: AppTextStyles.h6(
                context,
              ).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ],
        ),

        // ISBN (se disponível)
        if (book.isbn != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.qr_code_2, size: 16, color: context.textMuted),
              const SizedBox(width: 6),
              Text(
                'ISBN: ${book.isbn}',
                style: AppTextStyles.bodySmall(
                  context,
                ).copyWith(color: context.textMuted, fontSize: 13),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
