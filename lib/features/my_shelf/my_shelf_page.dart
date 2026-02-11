import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import 'my_shelf_controller.dart';
import 'my_shelf_repository.dart';
import 'widgets/shelf_header.dart';
import 'widgets/shelf_filter_chips.dart';
import 'widgets/shelf_book_card.dart';

class MyShelfPage extends StatelessWidget {
  const MyShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyShelfController(repository: MyShelfRepository()),
      child: const _MyShelfView(),
    );
  }
}

class _MyShelfView extends StatefulWidget {
  const _MyShelfView();

  @override
  State<_MyShelfView> createState() => _MyShelfViewState();
}

class _MyShelfViewState extends State<_MyShelfView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<MyShelfController>();

    if (controller.pendingNavigation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final event = controller.pendingNavigation;
        if (event != null && mounted) {
          Navigator.pushNamed(context, event.route, arguments: event.arguments);
          controller.clearNavigation();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyShelfController>();

    if (controller.isLoading) {
      return const LoadingState();
    }

    if (controller.errorMessage != null) {
      return ErrorState(
        message: controller.errorMessage!,
        onRetry: controller.refresh,
      );
    }

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header da estante
            const SliverToBoxAdapter(child: ShelfHeader()),

            // Barra de busca
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Buscar meus livros',
                        prefixIcon: Icons.search,
                        onChanged: (value) {
                          // TODO: Implementar busca
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    SquareIconButton(
                      icon: Icons.filter_list,
                      onPressed: () {
                        // TODO: Implementar filtro avançado
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: AppSpacing.verticalMD),

            // Filtros de status
            SliverToBoxAdapter(
              child: ShelfFilterChips(
                selectedFilter: controller.selectedFilter,
                onFilterSelected: controller.onFilterSelected,
              ),
            ),

            const SliverToBoxAdapter(child: AppSpacing.verticalMD),

            // Grade de livros do usuário
            if (controller.isEmpty)
              EmptyState(
                icon: Icons.auto_stories_outlined,
                title: 'Você ainda não adicionou livros',
                description: 'Toque em "Adicionar Livro" para começar',
                isSliverFillRemaining: true,
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.50,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.lg,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final book = controller.myBooks[index];
                    return ShelfBookCard(
                      book: book,
                      onTap: () => controller.onBookTap(book),
                      onMenuTap: () {
                        // TODO: Implementar menu de ações
                      },
                    );
                  }, childCount: controller.myBooks.length),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
