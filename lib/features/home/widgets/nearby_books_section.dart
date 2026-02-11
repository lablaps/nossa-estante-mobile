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
              Padding(
                padding: AppSpacing.paddingHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Livros Perto de Você',
                          style: AppTextStyles.h3(context),
                        ),
                        AppSpacing.horizontalSM,
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllBooks,
                      child: Text(
                        'Ver todos',
                        style: AppTextStyles.labelLarge(
                          context,
                        ).copyWith(color: context.primaryColor),
                      ),
                    ),
                  ],
                ),
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
                          return _BookCard(book: book);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Card de livro individual
///
/// Recebe [Book] de domínio e faz conversão visual
class _BookCard extends StatelessWidget {
  final Book book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    // Conversão domínio → visual
    final distance = _formatDistance(book);

    return GestureDetector(
      onTap: () {
        final controller = context.read<HomeController>();
        controller.onBookTap(book);
      },
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover
            Container(
              height: 168,
              decoration: BoxDecoration(
                borderRadius: AppDimensions.borderRadiusMD,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  BookPlaceholder(width: 140, height: 210, text: book.title),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: AppDimensions.borderRadiusSM,
                      ),
                      child: Text(
                        distance,
                        style: AppTextStyles.caption(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSM,

            // Book info
            Text(
              book.title,
              style: AppTextStyles.labelLarge(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book.author,
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(color: context.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.verticalXS,
            Row(
              children: [
                const Icon(Icons.token, color: AppColors.primary, size: 14),
                AppSpacing.horizontalXS,
                Text(
                  '${book.creditsRequired} ${_pluralize(book.creditsRequired)}',
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
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

  String _pluralize(int count) {
    return count == 1 ? 'Crédito' : 'Créditos';
  }
}
