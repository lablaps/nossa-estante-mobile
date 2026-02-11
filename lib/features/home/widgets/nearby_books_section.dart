import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/distance_formatter.dart';
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
          margin: const EdgeInsets.only(top: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: context.isDark
                    ? AppColors.borderTopDark
                    : AppColors.borderTopLight,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              SectionHeader(
                title: 'Livros Perto de Você',
                icon: Icons.location_on,
                onViewAll: controller.onViewAllNearby,
              ),
              AppSpacing.verticalMD,

              SizedBox(
                height: 290,
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
                          final distance = DistanceFormatter.format(
                            controller.currentUser.location,
                            book.owner.location,
                          );

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
}
