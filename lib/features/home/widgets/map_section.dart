import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Seção do mapa mostrando livros próximos
class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: EdgeInsets.only(top: AppSpacing.md),
      child: Stack(
        children: [
          // Map background (placeholder)
          const MapPlaceholder(width: double.infinity, height: 320),

          // Map pins (simulated)
          Positioned(
            top: 96,
            left: 160,
            child: _MapPin(icon: Icons.menu_book, color: AppColors.primary),
          ),
          Positioned(
            top: 192,
            left: 280,
            child: _MapPin(text: '3+', color: AppColors.primary),
          ),
          Positioned(
            top: 144,
            left: 80,
            child: _MapPin(icon: Icons.menu_book, color: AppColors.primary),
          ),

          // Floating location button
          Positioned(
            bottom: AppSpacing.md,
            right: AppSpacing.md,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: context.surfaceColor,
                shape: BoxShape.circle,
                border: Border.all(color: context.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.my_location, color: context.textColor),
            ),
          ),

          // Info badge
          Positioned(
            bottom: AppSpacing.md,
            left: AppSpacing.md,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm + 4,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: context.surfaceColor.withOpacity(0.9),
                borderRadius: AppDimensions.borderRadiusSM,
                border: Border.all(color: context.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppSpacing.horizontalXS,
                  AppSpacing.horizontalXS,
                  Text(
                    '24 livros em um raio de 5km',
                    style: AppTextStyles.caption(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Gradient fade at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, context.backgroundColor],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pin individual no mapa
class _MapPin extends StatelessWidget {
  final IconData? icon;
  final Color color;
  final String? text;

  const _MapPin({this.icon, required this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: icon != null ? 32 : 40,
          height: icon != null ? 32 : 40,
          decoration: BoxDecoration(
            color: text != null ? Colors.white : color,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: icon != null
              ? Icon(icon, color: Colors.white, size: 18)
              : Center(
                  child: Text(
                    text ?? '',
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        CustomPaint(size: const Size(12, 8), painter: _TrianglePainter(color)),
      ],
    );
  }
}

/// Painter para o triângulo do pin do mapa
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
