import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import 'explore_controller.dart';
import 'explore_repository.dart';
import 'widgets/explore_header.dart';
import 'widgets/explore_search_bar.dart';
import 'widgets/genre_filter_chips.dart';
import 'widgets/curated_collection_card.dart';
import 'widgets/catalog_list_item.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreController(repository: ExploreRepository()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatefulWidget {
  const _ExploreView();

  @override
  State<_ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<_ExploreView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<ExploreController>();

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
    final controller = context.watch<ExploreController>();

    if (controller.isLoading) {
      return Scaffold(
        backgroundColor: context.backgroundColor,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (controller.errorMessage != null) {
      return Scaffold(
        backgroundColor: context.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.isDark ? AppColors.slate600 : AppColors.slate400,
              ),
              AppSpacing.verticalMD,
              Text(
                controller.errorMessage!,
                style: AppTextStyles.bodyMedium(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: ExploreHeader(user: controller.currentUser),
            ),

            // Search Bar
            const SliverToBoxAdapter(child: ExploreSearchBar()),

            // Genre Filter Chips
            SliverToBoxAdapter(
              child: GenreFilterChips(
                genres: controller.genres,
                selectedGenre: controller.selectedGenre,
                onGenreSelected: controller.onFilterSelected,
              ),
            ),

            AppSpacing.verticalMD.toSliver,

            // Curated Collections Section
            SliverToBoxAdapter(
              child: _CuratedCollectionsSection(
                collections: controller.curatedCollections,
                onCollectionTap: controller.onCollectionTap,
              ),
            ),

            AppSpacing.verticalMD.toSliver,

            // Featured Books Section
            SliverToBoxAdapter(
              child: _FeaturedBooksSection(
                books: controller.featuredBooks,
                onBookTap: controller.onBookTap,
                onViewAll: controller.onViewAllFeatured,
              ),
            ),

            AppSpacing.verticalMD.toSliver,

            // New Arrivals Section
            SliverToBoxAdapter(
              child: _NewArrivalsSection(
                books: controller.newArrivals,
                onBookTap: controller.onBookTap,
                onAddTap: controller.onAddBookTap,
              ),
            ),

            // Bottom padding for navigation
            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.bottomNavPadding),
            ),
          ],
        ),
      ),
    );
  }
}

/// Seção de coleções curadas
class _CuratedCollectionsSection extends StatelessWidget {
  final List<CuratedCollection> collections;
  final ValueChanged<String> onCollectionTap;

  const _CuratedCollectionsSection({
    required this.collections,
    required this.onCollectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingHorizontal,
          child: Text('Coleções Curadas', style: AppTextStyles.h3(context)),
        ),
        AppSpacing.verticalMD,
        SizedBox(
          height: 144,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.paddingHorizontal,
            itemCount: collections.length,
            separatorBuilder: (context, index) => AppSpacing.horizontalMD,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return CuratedCollectionCard(
                collection: collection,
                onTap: () => onCollectionTap(collection.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Seção de livros em destaque
class _FeaturedBooksSection extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onBookTap;
  final VoidCallback onViewAll;

  const _FeaturedBooksSection({
    required this.books,
    required this.onBookTap,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Em destaque', onViewAll: onViewAll),
        AppSpacing.verticalMD,
        SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.paddingHorizontal,
            itemCount: books.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.md + 4),
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () => onBookTap(book),
                orientation: BookCardOrientation.vertical,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Seção de novidades do catálogo
class _NewArrivalsSection extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onBookTap;
  final ValueChanged<Book> onAddTap;

  const _NewArrivalsSection({
    required this.books,
    required this.onBookTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data para tempo de adição e distância
    final addedTimes = [
      'Adicionado hoje',
      'Ontem',
      '2 dias atrás',
      '3 dias atrás',
      '4 dias atrás',
    ];

    final distances = ['2.3 km', '5.1 km', '8.4 km', '12.0 km', '15.2 km'];

    return Padding(
      padding: AppSpacing.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Novidades do Catálogo', style: AppTextStyles.h3(context)),
          AppSpacing.verticalMD,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            separatorBuilder: (context, index) => AppSpacing.verticalMD,
            itemBuilder: (context, index) {
              final book = books[index];
              return CatalogListItem(
                book: book,
                distance: index < distances.length ? distances[index] : null,
                addedTime: index < addedTimes.length ? addedTimes[index] : null,
                onTap: () => onBookTap(book),
                onAddTap: () => onAddTap(book),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Extension para converter widgets em slivers
extension _WidgetToSliver on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
}
