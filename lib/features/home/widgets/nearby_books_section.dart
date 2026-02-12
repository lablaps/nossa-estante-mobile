import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class NearbyBooksSection extends StatelessWidget {
  final List<Book> nearbyBooks;
  final User currentUser;
  final bool isLoading;
  final VoidCallback? onViewAll;
  final ValueChanged<Book>? onBookTap;

  const NearbyBooksSection({
    super.key,
    required this.nearbyBooks,
    required this.currentUser,
    required this.isLoading,
    this.onViewAll,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
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
            onViewAll: onViewAll,
          ),
          AppSpacing.verticalMD,
          SizedBox(
            height: 290,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : nearbyBooks.isEmpty
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
                    itemCount: nearbyBooks.length,
                    separatorBuilder: (_, __) => AppSpacing.horizontalMD,
                    itemBuilder: (context, index) {
                      final book = nearbyBooks[index];

                      return BookCard(
                        book: book,
                        onTap: onBookTap != null
                            ? () => onBookTap!(book)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
