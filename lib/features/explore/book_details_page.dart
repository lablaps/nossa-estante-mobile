import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import 'controller/book_details_controller.dart';
import 'widgets/book_info_chips.dart';
import 'widgets/owner_profile_card.dart';
import 'widgets/location_map_preview.dart';
import 'widgets/book_details_bottom_bar.dart';
import 'widgets/real_book_photos.dart';

/// Página de detalhes de um livro
///
/// Exibe informações completas sobre um livro disponível,
/// incluindo capa, descrição, informações do dono e localização.
class BookDetailsPage extends StatelessWidget {
  final Book book;
  final User? currentUser;

  const BookDetailsPage({super.key, required this.book, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          BookDetailsController(book: book, currentUser: currentUser),
      child: const _BookDetailsView(),
    );
  }
}

class _BookDetailsView extends StatelessWidget {
  const _BookDetailsView();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailsController>(
      builder: (context, controller, _) {
        // Handle navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final navigation = controller.pendingNavigation;
          if (navigation != null) {
            controller.clearNavigation();
            if (navigation.isPop) {
              Navigator.of(context).pop();
            } else if (navigation.route != null) {
              Navigator.pushNamed(
                context,
                navigation.route!,
                arguments: navigation.arguments,
              );
            }
          }
        });

        return _buildContent(context, controller);
      },
    );
  }

  Widget _buildContent(BuildContext context, BookDetailsController controller) {
    final book = controller.book;
    return Scaffold(
      body: Stack(
        children: [
          // Conteúdo principal com scroll
          CustomScrollView(
            slivers: [
              // AppBar com fundo transparente
              SliverAppBar(
                backgroundColor: context.surfaceColor.withValues(
                  alpha: AppDimensions.opacityVeryHigh,
                ),
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: controller.onBackTap,
                ),
                title: Text('Book Details', style: AppTextStyles.h5(context)),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: controller.onShareTap,
                  ),
                ],
              ),

              // Conteúdo
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Capa do livro com efeito blur
                    _BookCoverHeader(book: book),

                    // Informações do livro
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Badge
                          _StatusBadge(status: book.status),
                          const SizedBox(height: 8),

                          // Título e autor
                          Text(
                            book.title,
                            style: AppTextStyles.h1(context).copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          AppSpacing.verticalSM,
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                book.author,
                                style: AppTextStyles.h6(context).copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          // ISBN (se disponível)
                          if (book.isbn != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code_2,
                                  size: 16,
                                  color: context.textMuted,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'ISBN: ${book.isbn}',
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: context.textMuted,
                                        fontSize: 13,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Chips de informação
                    BookInfoChips(book: book),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      child: Divider(
                        height: 1,
                        thickness: 1.5,
                        color: context.borderColor.withValues(
                          alpha: AppDimensions.opacityMediumHigh,
                        ),
                      ),
                    ),

                    // Perfil do dono
                    Padding(
                      padding: AppSpacing.paddingPage,
                      child: OwnerProfileCard(
                        owner: book.owner,
                        onMessageTap: controller.onMessageTap,
                      ),
                    ),

                    // Sinopse
                    if (book.description != null &&
                        book.description!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Synopsis',
                              style: AppTextStyles.h5(context).copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              book.description!,
                              style: AppTextStyles.bodyLarge(context).copyWith(
                                color: context.isDark
                                    ? AppColors
                                          .captionText // gray-300
                                    : AppColors.mutedText, // gray-600
                                height: 1.6,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalSM,
                    ],

                    // Fotos reais do livro
                    if (book.realBookPhotos.isNotEmpty) ...[
                      Padding(
                        padding: AppSpacing.paddingPage,
                        child: RealBookPhotos(photoUrls: book.realBookPhotos),
                      ),
                      AppSpacing.verticalMD,
                    ],

                    // Localização
                    if (book.owner.location != null) ...[
                      Padding(
                        padding: AppSpacing.paddingPage,
                        child: LocationMapPreview(
                          ownerLocation: book.owner.location!,
                          currentLocation: controller.currentUser?.location,
                        ),
                      ),
                      AppSpacing.verticalMD,
                    ],

                    // Espaço para o bottom bar
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),

          // Barra de ação inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BookDetailsBottomBar(
              creditsRequired: book.creditsRequired,
              onRedeemTap: () {
                // TODO: Implementar resgate do livro
                _showRedeemDialog(context, controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRedeemDialog(
    BuildContext context,
    BookDetailsController controller,
  ) {
    final book = controller.book;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Resgatar Livro'),
        content: Text(
          'Deseja resgatar "${book.title}" por ${book.creditsRequired} créditos?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implementar lógica de resgate
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

/// Widget do cabeçalho com capa do livro e efeito blur
class _BookCoverHeader extends StatelessWidget {
  final Book book;

  const _BookCoverHeader({required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Stack(
        children: [
          // Imagem de fundo com blur
          if (book.coverUrl != null)
            Positioned.fill(
              child: Image.network(
                book.coverUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

          // Overlay blur
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: context.surfaceColor.withValues(
                  alpha: AppDimensions.opacityMedium,
                ),
              ),
              child: ImageFiltered(
                imageFilter: const ColorFilter.mode(
                  AppColors.transparent,
                  BlendMode.dst,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.surfaceColor.withValues(
                          alpha: AppDimensions.opacityMediumHigh,
                        ),
                        context.surfaceColor.withValues(
                          alpha: AppDimensions.opacityVeryHigh,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Capa do livro centralizada
          Center(
            child: Hero(
              tag: 'book-${book.id}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppDimensions.borderRadiusMD,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowDarker,
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: BookCover(
                  coverUrl: book.coverUrl,
                  width: 220,
                  height: 340,
                  fallbackText: book.title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget de badge de status do livro
class _StatusBadge extends StatelessWidget {
  final BookStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case BookStatus.available:
        backgroundColor = AppColors.statusAvailable.withValues(
          alpha: AppDimensions.opacityMedium,
        ); // green
        textColor = const Color(0xFF059669); // emerald-600
        icon = Icons.check_circle_outline;
        break;
      case BookStatus.inExchange:
        backgroundColor = AppColors.statusInExchange.withValues(
          alpha: AppDimensions.opacityMedium,
        ); // amber
        textColor = const Color(0xFFD97706); // amber-600
        icon = Icons.sync_outlined;
        break;
      case BookStatus.unavailable:
        backgroundColor = AppColors.statusUnavailable.withValues(
          alpha: AppDimensions.opacityMedium,
        ); // gray
        textColor = const Color(0xFF4B5563); // gray-600
        icon = Icons.schedule_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: AppTextStyles.caption(context).copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
