import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Barra de ação inferior da tela de detalhes do livro
///
/// Exibe o custo em créditos e o botão de resgate.
class BookDetailsBottomBar extends StatelessWidget {
  final int creditsRequired;
  final VoidCallback? onRedeemTap;

  const BookDetailsBottomBar({
    super.key,
    required this.creditsRequired,
    this.onRedeemTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.bookDetailsSurface : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Row(
            children: [
              // Custo em créditos
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Cost',
                    style: AppTextStyles.caption(context).copyWith(
                      color: context.isDark
                          ? AppColors
                                .captionText // gray-400
                          : const Color(0xFF6B7280), // gray-500
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        creditsRequired.toString(),
                        style: AppTextStyles.h1(
                          context,
                        ).copyWith(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Credits',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: context.isDark
                              ? AppColors.primary
                              : const Color(0xFF059669), // emerald-600
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              AppSpacing.horizontalMD,

              // Botão de resgate
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: onRedeemTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: const Color(0xFF102216),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: AppColors.primary.withValues(
                        alpha: AppDimensions.opacityMediumLow,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resgatar livro',
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            color: const Color(0xFF102216),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.shopping_bag_outlined, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
