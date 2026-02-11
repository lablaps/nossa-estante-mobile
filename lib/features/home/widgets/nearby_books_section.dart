import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/mocks/mocks.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../home_controller.dart';

/// Seção de livros próximos da home
class NearbyBooksSection extends StatelessWidget {
  const NearbyBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Container(
          margin: AppSpacing.marginBooksSection,
          padding: AppSpacing.paddingBooksSection,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: (context.isDark ? Colors.white : Colors.white)
                    .withOpacity(context.isDark ? 0.05 : 0.5),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Section header
              SectionHeader(
                title: 'Livros Perto de Você',
                icon: Icons.location_on,
                onViewAll: controller.onViewAllNearby,
              ),
              AppSpacing.verticalMD,

              // Horizontal book list
              SizedBox(
                height: 240,
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : controller.nearbyBooks.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum livro encontrado por perto',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(color: context.textMuted),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: AppSpacing.paddingHorizontal,
                        itemCount: controller.nearbyBooks.length,
                        separatorBuilder: (_, __) => AppSpacing.horizontalMD,
                        itemBuilder: (context, index) {
                          final book = controller.nearbyBooks[index];
                          final distance = _formatDistance(book);

                          return BookCard(
                            book: book,
                            distance: distance,
                            onTap: () => controller.onBookTap(book),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Formata distância baseado na localização do usuário
  String _formatDistance(Book book) {
    final currentUserLocation = MockUsers.currentUser.location;

    if (currentUserLocation == null || book.owner.location == null) {
      return 'Longe';
    }

    final distanceKm = currentUserLocation.distanceTo(book.owner.location!);

    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()}m';
    } else {
      return '${distanceKm.toStringAsFixed(1)}km';
    }
  }
}
