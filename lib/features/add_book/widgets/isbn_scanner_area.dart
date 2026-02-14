import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class IsbnScannerArea extends StatelessWidget {
  final VoidCallback onTap;

  const IsbnScannerArea({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: AppDimensions.borderRadiusXL,
            color: AppColors.surfaceDark,
            boxShadow: AppDimensions.shadowCard,
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image overlay
              Opacity(
                opacity: AppDimensions.opacityVeryHigh,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Dark overlay
              Container(color: AppColors.black.withValues(alpha: 0.4)),

              // Scanner frame
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Scanner frame with corners
                    _buildScannerFrame(),
                    AppSpacing.verticalLG,

                    // Scanner info
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.6),
                        borderRadius: AppDimensions.borderRadiusFull,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.barcode_reader,
                            color: AppColors.primary,
                            size: AppDimensions.iconMD,
                          ),
                          AppSpacing.horizontalSM,
                          Text(
                            'Escaneie o Código ISBN',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalSM,

                    // Help text
                    Text(
                      'Align barcode within the frame to auto-fill details',
                      style: AppTextStyles.caption(
                        context,
                      ).copyWith(color: AppColors.white.withValues(alpha: 0.8)),
                      textAlign: TextAlign.center,
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

  Widget _buildScannerFrame() {
    return SizedBox(
      width: 256,
      height: 128,
      child: Stack(
        children: [
          // Border with glow
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: AppDimensions.borderRadiusSM,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
          ),

          // Scanning line
          Center(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.8),
                boxShadow: [BoxShadow(color: AppColors.primary, blurRadius: 8)],
              ),
            ),
          ),

          // Corner brackets
          _buildCornerBracket(Alignment.topLeft, top: true, left: true),
          _buildCornerBracket(Alignment.topRight, top: true, right: true),
          _buildCornerBracket(Alignment.bottomLeft, bottom: true, left: true),
          _buildCornerBracket(Alignment.bottomRight, bottom: true, right: true),
        ],
      ),
    );
  }

  Widget _buildCornerBracket(
    Alignment alignment, {
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            bottom: bottom
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            left: left
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            right: right
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
          ),
        ),
        transform: Matrix4.translationValues(
          left ? -4 : (right ? 4 : 0),
          top ? -4 : (bottom ? 4 : 0),
          0,
        ),
      ),
    );
  }
}
