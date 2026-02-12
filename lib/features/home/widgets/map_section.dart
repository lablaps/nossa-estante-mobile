import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import 'animated_book_pin.dart';
import 'map_info_badge.dart';

class MapSection extends StatelessWidget {
  final List<Book> books;
  final int totalInRadius;
  final VoidCallback? onMapTap;

  const MapSection({
    super.key,
    required this.books,
    required this.totalInRadius,
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMapTap,
      child: Container(
        height: 320,
        margin: const EdgeInsets.only(top: AppSpacing.md),
        child: Stack(
          children: [
            const MapPlaceholder(width: double.infinity, height: 320),

            ..._buildBookPins(books),

            Positioned(
              bottom: AppSpacing.md,
              right: AppSpacing.md,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                  AppSpacing.verticalSM,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimensions.borderRadiusMD,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(
                            AppDimensions.opacityMedium,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.explore,
                          color: AppColors.white,
                          size: 18,
                        ),
                        AppSpacing.horizontalXS,
                        Text(
                          'Explorar',
                          style: AppTextStyles.labelMedium(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: AppSpacing.md,
              left: AppSpacing.md,
              child: MapInfoBadge(booksCount: totalInRadius, radius: 5),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBookPins(List<Book> books) {
    if (books.isEmpty) return [];

    final positions = [
      const Offset(160, 96),
      const Offset(280, 192),
      const Offset(80, 144),
      const Offset(200, 160),
    ];

    final delays = [0, 200, 400, 600];

    return books.take(positions.length).toList().asMap().entries.map((entry) {
      final index = entry.key;
      final book = entry.value;
      final position = positions[index];
      final delay = delays[index];

      return Positioned(
        top: position.dy,
        left: position.dx,
        child: AnimatedBookPin(
          book: book,
          delay: Duration(milliseconds: delay),
        ),
      );
    }).toList();
  }
}
