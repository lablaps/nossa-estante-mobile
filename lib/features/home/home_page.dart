import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import 'home_controller.dart';
import 'home_repository.dart';
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
      create: (_) => HomeController(repository: HomeRepository()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<HomeController>();

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
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(
                user: controller.currentUser,
                onNotificationsTap: controller.onNotificationTap,
              ),
            ),

            const SliverToBoxAdapter(child: HomeSearchBar()),

            SliverToBoxAdapter(
              child: MapSection(
                books: controller.nearbyBooks,
                totalInRadius: controller.totalBooksInRadius,
                onMapTap: controller.onMapTap,
              ),
            ),

            const SliverToBoxAdapter(child: NearbyBooksSection()),

            const SliverToBoxAdapter(child: CommunityActivitySection()),

            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.bottomNavPadding),
            ),
          ],
        ),
      ),
    );
  }
}
