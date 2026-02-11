import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../explore_controller.dart';

/// Card de coleção curada
///
/// Exibe um card estilo banner com imagem, badge e informações.
/// Não contém lógica de navegação - usa callback [onTap].
class CuratedCollectionCard extends StatelessWidget {
  final CuratedCollection collection;
  final VoidCallback onTap;

  const CuratedCollectionCard({
    super.key,
    required this.collection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 256,
        height: 144,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  collection.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildImageFallback(context),
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.black.withOpacity(0.8),
                        AppColors.black.withOpacity(0.4),
                        AppColors.black.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                left: AppSpacing.md + 4,
                right: AppSpacing.xxxl,
                bottom: AppSpacing.md + 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs - 2,
                      ),
                      decoration: BoxDecoration(
                        color: collection.badgeColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXS - 4,
                        ),
                      ),
                      child: Text(
                        collection.badgeText,
                        style: AppTextStyles.caption(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    AppSpacing.verticalSM,

                    // Title
                    Text(
                      collection.title,
                      style: AppTextStyles.h5(
                        context,
                      ).copyWith(color: AppColors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.verticalXS,

                    // Description
                    Text(
                      collection.description,
                      style: AppTextStyles.caption(
                        context,
                      ).copyWith(color: AppColors.slate200),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageFallback(BuildContext context) {
    return Container(
      color: context.isDark ? AppColors.surfaceDark : AppColors.slate200,
      child: Center(
        child: Icon(
          Icons.collections_bookmark,
          size: 48,
          color: context.isDark ? AppColors.slate600 : AppColors.slate400,
        ),
      ),
    );
  }
}
