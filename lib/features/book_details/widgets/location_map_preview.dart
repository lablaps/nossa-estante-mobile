import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/distance_formatter.dart';

/// Widget que exibe preview do mapa com localização do dono
///
/// Mostra um mapa estático com um indicador de distância.
class LocationMapPreview extends StatelessWidget {
  final UserLocation ownerLocation;
  final UserLocation? currentLocation;

  const LocationMapPreview({
    super.key,
    required this.ownerLocation,
    this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    final distance = _calculateDistance();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Localização',
          style: AppTextStyles.h5(
            context,
          ).copyWith(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Container(
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.isDark
                ? const Color(0xFF1F2937) // gray-800
                : const Color(0xFFE5E7EB), // gray-200
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Mapa estático (simulado com gradiente)
                _buildMapPlaceholder(context),

                // Overlay com distância
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.isDark
                          ? const Color(0xFF102216) // background-dark
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(
                            alpha: AppDimensions.opacityLow,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Color(0xFFEF4444), // red-500
                        ),
                        const SizedBox(width: 6),
                        Text(
                          distance,
                          style: AppTextStyles.caption(
                            context,
                          ).copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.surfaceDark, AppColors.backgroundDark]
              : [
                  AppColors.slate200,
                  AppColors.slate400.withValues(
                    alpha: AppDimensions.opacityMedium,
                  ),
                ],
        ),
      ),
      child: CustomPaint(painter: _MapPatternPainter(isDark: isDark)),
    );
  }

  String _calculateDistance() {
    if (currentLocation == null) {
      return '1.2 km away';
    }

    return '${DistanceFormatter.format(currentLocation, ownerLocation)} away';
  }
}

/// Painter para criar um padrão de mapa simplificado
class _MapPatternPainter extends CustomPainter {
  final bool isDark;

  _MapPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? AppColors.borderDark : AppColors.borderLight)
          .withValues(alpha: AppDimensions.opacityMedium)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Linhas verticais
    for (var i = 0; i < 5; i++) {
      final x = (size.width / 5) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Linhas horizontais
    for (var i = 0; i < 3; i++) {
      final y = (size.height / 3) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Círculos simulando pontos de interesse
    final circlePaint = Paint()
      ..color = AppColors.primary.withValues(
        alpha: AppDimensions.opacityMediumLow,
      )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.6),
      8,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.4),
      6,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
