import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Widget do cabeçalho com capa do livro e efeito blur
///
/// Exibe a capa do livro em destaque com um fundo desfocado
/// e efeito de gradiente para melhor legibilidade.
class BookCoverHeader extends StatelessWidget {
  final Book book;

  const BookCoverHeader({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Stack(
        children: [
          // Imagem de fundo com blur
          if (book.coverUrl != null)
            Positioned.fill(
              child: Image.network(
                book.coverUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

          // Overlay blur
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: context.surfaceColor.withValues(
                  alpha: AppDimensions.opacityMedium,
                ),
              ),
              child: ImageFiltered(
                imageFilter: const ColorFilter.mode(
                  AppColors.transparent,
                  BlendMode.dst,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.surfaceColor.withValues(
                          alpha: AppDimensions.opacityMediumHigh,
                        ),
                        context.surfaceColor.withValues(
                          alpha: AppDimensions.opacityVeryHigh,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Capa do livro centralizada
          Center(
            child: Hero(
              tag: 'book-${book.id}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppDimensions.borderRadiusMD,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowDarker,
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: BookCover(
                  coverUrl: book.coverUrl,
                  width: 220,
                  height: 340,
                  fallbackText: book.title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
