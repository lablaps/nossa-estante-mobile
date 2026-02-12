import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Widget que exibe a sinopse do livro
///
/// Renderiza a descrição do livro em um layout formatado com título.
class BookSynopsisSection extends StatelessWidget {
  final String description;

  const BookSynopsisSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sinopse',
          style: AppTextStyles.h5(
            context,
          ).copyWith(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: AppTextStyles.bodyLarge(context).copyWith(
            color: context.isDark
                ? AppColors
                      .captionText // gray-300
                : AppColors.mutedText, // gray-600
            height: 1.6,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
