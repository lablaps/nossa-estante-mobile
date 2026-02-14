import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/theme/theme.dart';
import 'book_details_controller.dart';
import 'widgets/widgets.dart';

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
                title: Text(
                  'Detalhes do livro',
                  style: AppTextStyles.h5(context),
                ),
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
                    BookCoverHeader(book: book),

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
                          BookStatusBadge(status: book.status),
                          const SizedBox(height: 8),

                          // Título, autor e ISBN
                          BookInfoSection(book: book),
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
                        child: BookSynopsisSection(
                          description: book.description!,
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
              onRedeemTap: () => _handleRedeemTap(context, controller),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRedeemTap(
    BuildContext context,
    BookDetailsController controller,
  ) {
    BookRedeemDialog.show(
      context: context,
      book: controller.book,
      onConfirm: () {
        // TODO: Implementar lógica de resgate
      },
    );
  }
}
