import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Widget placeholder para mapa quando não há conexão ou imagem disponível
class MapPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const MapPlaceholder({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: AppDimensions.borderRadiusMD,
      ),
      child: Stack(
        children: [
          // Grid pattern
          CustomPaint(
            size: Size(width ?? double.infinity, height ?? double.infinity),
            painter: _GridPainter(
              context.isDark ? Colors.grey[700]! : Colors.grey[300]!,
            ),
          ),
          // Center icon
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 48,
                  color: context.isDark ? Colors.grey[600] : Colors.grey[400],
                ),
                AppSpacing.verticalSM,
                Text(
                  'Mapa',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: context.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter para criar um padrão de grade simples
class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    // Linhas verticais
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Linhas horizontais
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => oldDelegate.color != color;
}
