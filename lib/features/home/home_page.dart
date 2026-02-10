import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import 'home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/map_section.dart';
import 'widgets/nearby_books_section.dart';
import 'widgets/community_activity_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header
            const SliverToBoxAdapter(child: HomeHeader()),

            // Search Bar
            const SliverToBoxAdapter(child: HomeSearchBar()),

            // Map Section
            const SliverToBoxAdapter(child: MapSection()),

            // Books Near You
            const SliverToBoxAdapter(child: NearbyBooksSection()),

            // Community Activity
            const SliverToBoxAdapter(child: CommunityActivitySection()),

            // Bottom padding for navigation bar
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxxl + 16)),
          ],
        ),
      ),
    );
  }
}
