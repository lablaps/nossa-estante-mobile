import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Widget placeholder para livros quando não há imagem disponível
class BookPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;

  const BookPlaceholder({super.key, this.width, this.height, this.text});

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? 140.0;
    final effectiveHeight = height ?? 210.0;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary.withOpacity(0.7), AppColors.primary],
          ),
          borderRadius: AppDimensions.borderRadiusMD,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: (effectiveWidth * 0.3).clamp(20.0, 60.0),
              color: AppColors.white.withOpacity(AppDimensions.opacityVeryHigh),
            ),
            if (text != null && effectiveHeight > 80) ...[
              SizedBox(height: 8),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    text!,
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.white.withOpacity(
                        AppDimensions.opacityVeryHigh,
                      ),
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
