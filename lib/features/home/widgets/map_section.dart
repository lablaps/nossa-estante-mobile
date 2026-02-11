import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/mocks/mocks.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../home_controller.dart';

/// Seção do mapa mostrando livros próximos
///
/// Recebe dados de livros do controller e calcula informações dinamicamente
class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        final totalBooksInRadius = _countBooksInRadius(controller.nearbyBooks);

        return GestureDetector(
          onTap: controller.onMapTap,
          child: Container(
            height: 320,
            margin: AppSpacing.marginMapSection,
            child: Stack(
              children: [
                // Map background (placeholder)
                const MapPlaceholder(width: double.infinity, height: 320),

                // Map pins baseados em livros reais
                ..._buildMapPins(controller.nearbyBooks),

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
                          color: AppColors.shadowMedium,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.my_location, color: context.textColor),
                  ),
                ),

                // Info badge com dados reais
                Positioned(
                  bottom: AppSpacing.md,
                  left: AppSpacing.md,
                  child: _MapInfoBadge(
                    booksCount: totalBooksInRadius,
                    radius: 5,
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
          ),
        );
      },
    );
  }

  /// Constrói pins no mapa baseado em livros reais
  List<Widget> _buildMapPins(List<Book> books) {
    if (books.isEmpty) return [];

    // Posições simuladas (em produção, seriam calculadas por coordenadas)
    final positions = [
      const Offset(160, 96),
      const Offset(280, 192),
      const Offset(80, 144),
      const Offset(200, 160),
    ];

    return books.take(positions.length).toList().asMap().entries.map((entry) {
      final index = entry.key;
      final position = positions[index];

      return Positioned(
        top: position.dy,
        left: position.dx,
        child: _MapPin(icon: Icons.menu_book, color: AppColors.primary),
      );
    }).toList();
  }

  /// Conta livros dentro de um raio (simplificado)
  int _countBooksInRadius(List<Book> books) {
    final currentLocation = MockUsers.currentUser.location;
    if (currentLocation == null) return books.length;

    return books.where((book) {
      final ownerLocation = book.owner.location;
      if (ownerLocation == null) return false;

      final distance = currentLocation.distanceTo(ownerLocation);
      return distance <= 5.0; // 5km de raio
    }).length;
  }
}

/// Badge com informações do mapa
class _MapInfoBadge extends StatelessWidget {
  final int booksCount;
  final int radius;

  const _MapInfoBadge({required this.booksCount, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMapInfo,
      decoration: BoxDecoration(
        color: context.surfaceColor.withOpacity(AppDimensions.opacityVeryHigh),
        borderRadius: AppDimensions.borderRadiusSM,
        border: Border.all(color: context.borderColor),
        boxShadow: [BoxShadow(color: AppColors.shadowLight, blurRadius: 4)],
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
            '$booksCount ${_pluralize(booksCount)} em um raio de ${radius}km',
            style: AppTextStyles.caption(
              context,
            ).copyWith(fontWeight: FontWeight.w600, color: context.textMuted),
          ),
        ],
      ),
    );
  }

  String _pluralize(int count) {
    return count == 1 ? 'livro' : 'livros';
  }
}

/// Pin individual no mapa
class _MapPin extends StatelessWidget {
  final IconData? icon;
  final Color color;

  const _MapPin({this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDarker,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon ?? Icons.menu_book,
            color: AppColors.white,
            size: 18,
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
