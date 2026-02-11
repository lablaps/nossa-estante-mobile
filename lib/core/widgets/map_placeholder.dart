import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Widget placeholder para mapa - exibe mapa estático visual
class MapPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const MapPlaceholder({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // Coordenadas de exemplo (Lisboa, Portugal)
    const lat = 38.7223;
    const lng = -9.1393;
    const zoom = 14;

    // Garante valores finitos para a URL do mapa
    final mapWidth = (width != null && width!.isFinite) ? width!.toInt() : 600;
    final mapHeight = (height != null && height!.isFinite)
        ? height!.toInt()
        : 320;

    // Usando OpenStreetMap static map (não requer API key)
    // Alternativa: pode usar uma imagem local de mapa ou outro serviço
    final mapUrl =
        'https://staticmap.openstreetmap.de/staticmap.php'
        '?center=$lat,$lng'
        '&zoom=$zoom'
        '&size=${mapWidth}x$mapHeight'
        '&maptype=mapnik';

    return ClipRRect(
      borderRadius: AppDimensions.borderRadiusMD,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.isDark ? Colors.grey[800] : Colors.grey[200],
        ),
        child: Image.network(
          mapUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback para grid pattern se imagem falhar
            return _FallbackMap(width: width, height: height);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _FallbackMap(width: width, height: height);
          },
        ),
      ),
    );
  }
}

/// Mapa fallback com grid pattern
class _FallbackMap extends StatelessWidget {
  final double? width;
  final double? height;

  const _FallbackMap({this.width, this.height});

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
