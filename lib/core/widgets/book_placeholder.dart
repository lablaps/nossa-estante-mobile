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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary.withOpacity(0.7), AppColors.primary],
        ),
        borderRadius: AppDimensions.borderRadiusMD,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: (width ?? 140) * 0.3,
              color: Colors.white.withOpacity(0.9),
            ),
            if (text != null) ...[
              AppSpacing.verticalSM,
              Padding(
                padding: EdgeInsets.all(AppSpacing.xs),
                child: Text(
                  text!,
                  style: AppTextStyles.caption(
                    context,
                  ).copyWith(color: Colors.white.withOpacity(0.9)),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
