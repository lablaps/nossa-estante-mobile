import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Item de lista de novidades do catálogo
///
/// Exibe informações de um livro em formato horizontal com botão de adicionar.
/// Não contém lógica de navegação - usa callbacks [onTap] e [onAddTap].
class CatalogListItem extends StatelessWidget {
  final Book book;
  final String? distance;
  final String? addedTime;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  const CatalogListItem({
    super.key,
    required this.book,
    this.distance,
    this.addedTime,
    this.onTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm + 4),
        decoration: BoxDecoration(
          color: context.isDark ? AppColors.surfaceDark : AppColors.white,
          borderRadius: AppDimensions.borderRadiusLG,
          border: Border.all(
            color: context.isDark
                ? AppColors.borderDark.withOpacity(0.5)
                : AppColors.borderLight.withOpacity(0.5),
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
            // Book cover
            BookCover(
              coverUrl: book.coverUrl,
              width: 56,
              height: 80,
              fallbackText: book.title,
            ),
            AppSpacing.horizontalMD,

            // Book info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and author
                  Text(
                    book.title,
                    style: AppTextStyles.h6(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: context.isDark
                          ? AppColors.slate400
                          : AppColors.slate600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.verticalSM,

                  // Metadata row
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Credits badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? AppColors.slate800
                              : AppColors.slate200,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXS,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.token,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${book.creditsRequired} ${book.creditsRequired == 1 ? 'Crédito' : 'Créditos'}',
                              style: AppTextStyles.caption(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),

                      // Added time
                      if (addedTime != null) ...[
                        Text(
                          addedTime!,
                          style: AppTextStyles.caption(context).copyWith(
                            color: context.isDark
                                ? AppColors.slate400
                                : AppColors.slate600,
                          ),
                        ),

                        // Divider
                        Container(
                          width: 1,
                          height: 12,
                          color: context.isDark
                              ? AppColors.slate600
                              : AppColors.slate400,
                        ),
                      ],

                      // Distance
                      if (distance != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 10,
                              color: context.isDark
                                  ? AppColors.slate400
                                  : AppColors.slate600,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              distance!,
                              style: AppTextStyles.caption(context).copyWith(
                                color: context.isDark
                                    ? AppColors.slate400
                                    : AppColors.slate600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Add button
            if (onAddTap != null) ...[
              AppSpacing.horizontalSM,
              GestureDetector(
                onTap: onAddTap,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? AppColors.slate800
                        : AppColors.slate200.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: AppDimensions.iconSM,
                    color: context.isDark
                        ? AppColors.slate400
                        : AppColors.slate600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
