import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Card de livro para My Shelf com badge de status e condição
///
/// Refatorado para usar StatusBadge e ConditionBadge do core/widgets.
class ShelfBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  const ShelfBookCard({
    super.key,
    required this.book,
    this.onTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover with badge
          Expanded(
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Stack(
                children: [
                  // Cover
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppDimensions.borderRadiusMD,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowDark,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: AppDimensions.borderRadiusMD,
                      child: BookCover(
                        coverUrl: book.coverUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fallbackText: book.title,
                      ),
                    ),
                  ),

                  // Status badge
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: StatusBadge(status: book.status),
                  ),

                  // Menu button
                  if (onMenuTap != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onMenuTap,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.overlayDark,
                            borderRadius: AppDimensions.borderRadiusFull,
                          ),
                          child: const Icon(
                            Icons.more_vert,
                            size: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            book.title,
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(fontWeight: FontWeight.bold, height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 2),

          // Author
          Text(
            book.author,
            style: AppTextStyles.caption(
              context,
            ).copyWith(color: context.textMuted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Condition badge
          ConditionBadge(condition: book.condition),
        ],
      ),
    );
  }
}
