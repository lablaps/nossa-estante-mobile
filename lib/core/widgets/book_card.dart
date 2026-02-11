import 'package:flutter/material.dart';
import '../domain/entities/entities.dart';
import '../theme/theme.dart';
import 'book_cover.dart';

/// Orientação do card de livro
enum BookCardOrientation { vertical, horizontal }

/// Card de livro reutilizável
///
/// Exibe informações de um livro com suporte para orientação vertical (padrão)
/// ou horizontal. Não contém lógica de navegação - usa callback [onTap].
class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;
  final BookCardOrientation orientation;
  final String? distance;

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
    this.orientation = BookCardOrientation.vertical,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return orientation == BookCardOrientation.vertical
        ? _VerticalBookCard(book: book, onTap: onTap, distance: distance)
        : _HorizontalBookCard(book: book, onTap: onTap, distance: distance);
  }
}

String _pluralize(int count) => count == 1 ? 'Crédito' : 'Créditos';

/// Card de livro vertical
class _VerticalBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;
  final String? distance;

  const _VerticalBookCard({required this.book, this.onTap, this.distance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover
            Container(
              width: 140,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: AppDimensions.borderRadiusMD,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowDark,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  BookCover(
                    coverUrl: book.coverUrl,
                    width: 140,
                    height: 210,
                    fallbackText: book.title,
                  ),
                  if (distance != null)
                    Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: Container(
                        padding: AppSpacing.paddingDistanceBadge,
                        decoration: BoxDecoration(
                          color: AppColors.overlayDark,
                          borderRadius: AppDimensions.borderRadiusSM,
                        ),
                        child: Text(
                          distance!,
                          style: AppTextStyles.caption(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            AppSpacing.verticalSM,
            _BookInfo(book: book),
          ],
        ),
      ),
    );
  }
}

/// Card de livro horizontal
class _HorizontalBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;
  final String? distance;

  const _HorizontalBookCard({required this.book, this.onTap, this.distance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingCard,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: AppDimensions.borderRadiusMD,
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Book cover
            Container(
              width: 60,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: AppDimensions.borderRadiusSM,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BookCover(
                coverUrl: book.coverUrl,
                width: 60,
                height: 90,
                fallbackText: book.title,
                borderRadius: AppDimensions.borderRadiusSM,
              ),
            ),
            AppSpacing.horizontalMD,

            // Book info
            Expanded(
              child: _BookInfo(
                book: book,
                maxTitleLines: 2,
                distance: distance,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget reutilizável para informações do livro
class _BookInfo extends StatelessWidget {
  final Book book;
  final int maxTitleLines;
  final String? distance;

  const _BookInfo({required this.book, this.maxTitleLines = 1, this.distance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: AppTextStyles.labelLarge(context),
          maxLines: maxTitleLines,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          book.author,
          style: AppTextStyles.bodySmall(
            context,
          ).copyWith(color: context.textMuted),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppSpacing.verticalXS,
        Row(
          children: [
            const Icon(Icons.token, color: AppColors.primary, size: 14),
            AppSpacing.horizontalXS,
            Text(
              '${book.creditsRequired} ${_pluralize(book.creditsRequired)}',
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            if (distance != null) ...[
              AppSpacing.horizontalSM,
              const Icon(Icons.location_on, color: AppColors.primary, size: 14),
              AppSpacing.horizontalXS,
              Text(distance!, style: AppTextStyles.bodySmall(context)),
            ],
          ],
        ),
      ],
    );
  }
}
