import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class MapInfoBadge extends StatelessWidget {
  final int booksCount;
  final int radius;

  const MapInfoBadge({
    super.key,
    required this.booksCount,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingBadge,
      decoration: BoxDecoration(
        color: context.surfaceColor.withOpacity(AppDimensions.opacityVeryHigh),
        borderRadius: AppDimensions.borderRadiusMD,
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(
                    AppDimensions.opacityMediumHigh,
                  ),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          AppSpacing.horizontalXS,
          AppSpacing.horizontalXS,
          Text(
            '$booksCount ${_pluralize(booksCount)} em até ${radius}km',
            style: AppTextStyles.caption(
              context,
            ).copyWith(fontWeight: FontWeight.w600, color: context.textColor),
          ),
        ],
      ),
    );
  }

  String _pluralize(int count) {
    return count == 1 ? 'livro' : 'livros';
  }
}
