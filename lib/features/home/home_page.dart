import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import 'home_controller.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header
            _buildHeader(context, isDark),

            // Search Bar
            _buildSearchBar(context, isDark),

            // Map Section
            SliverToBoxAdapter(child: _buildMapSection(context, isDark)),

            // Books Near You
            SliverToBoxAdapter(child: _buildNearbyBooks(context, isDark)),

            // Community Activity
            SliverToBoxAdapter(child: _buildCommunityActivity(context, isDark)),

            // Bottom padding for navigation bar
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and credits
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo,',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textMutedLight
                                : AppColors.textMuted,
                          ),
                        ),
                        Text(
                          'Sarah Jenkins',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textLight
                                : AppColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.token,
                        color: isDark
                            ? AppColors.primary
                            : AppColors.primaryDark,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12 Créditos',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.primary
                              : AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title and notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nossa Estante',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.textLight : AppColors.textMain,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: isDark ? AppColors.textLight : AppColors.textMain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Search input
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withOpacity(
                    0.05,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.search,
                      color: isDark
                          ? AppColors.textMutedLight
                          : AppColors.textMuted,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar livros, autores ou gêneros',
                        hintStyle: TextStyle(
                          color:
                              (isDark
                                      ? AppColors.textMutedLight
                                      : AppColors.textMuted)
                                  .withOpacity(0.7),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textLight
                            : AppColors.textMain,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: (isDark ? Colors.white : Colors.black)
                              .withOpacity(0.05),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: isDark ? AppColors.primary : AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Filter chips
            Consumer<HomeController>(
              builder: (context, controller, _) {
                return SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = controller.filters[index];
                      final isSelected = controller.selectedFilter == filter;

                      return GestureDetector(
                        onTap: () => controller.setFilter(filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : isDark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : (isDark ? Colors.white : Colors.black)
                                        .withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.black
                                  : isDark
                                  ? AppColors.textMutedLight
                                  : AppColors.textMuted,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context, bool isDark) {
    return Container(
      height: 320,
      margin: const EdgeInsets.only(top: 16),
      child: Stack(
        children: [
          // Map background (placeholder)
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              image: DecorationImage(
                image: NetworkImage(
                  'https://via.placeholder.com/400x320/e0e0e0/666666?text=Mapa',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade200,
                  BlendMode.lighten,
                ),
              ),
            ),
          ),

          // Map pins (simulated)
          Positioned(
            top: 96,
            left: 160,
            child: _buildMapPin(Icons.menu_book, AppColors.primary),
          ),
          Positioned(
            top: 192,
            left: 280,
            child: _buildMapPin(null, AppColors.primary, text: '3+'),
          ),
          Positioned(
            top: 144,
            left: 80,
            child: _buildMapPin(Icons.menu_book, AppColors.primary),
          ),

          // Floating location button
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withOpacity(
                    0.1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.my_location,
                color: isDark ? AppColors.textLight : AppColors.textMain,
              ),
            ),
          ),

          // Info badge
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
                    .withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withOpacity(
                    0.05,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '24 livros em um raio de 5km',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textMutedLight
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Gradient fade at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDark
                        ? AppColors.backgroundDark
                        : AppColors.backgroundLight,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(IconData? icon, Color color, {String? text}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: icon != null ? 32 : 40,
          height: icon != null ? 32 : 40,
          decoration: BoxDecoration(
            color: text != null ? Colors.white : color,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: icon != null
              ? Icon(icon, color: Colors.white, size: 18)
              : Center(
                  child: Text(
                    text ?? '',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
        CustomPaint(size: const Size(12, 8), painter: _TrianglePainter(color)),
      ],
    );
  }

  Widget _buildNearbyBooks(BuildContext context, bool isDark) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: (isDark ? Colors.white : Colors.white).withOpacity(
                  isDark ? 0.05 : 0.5,
                ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Livros Perto de Você',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textLight
                                : AppColors.textMain,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Ver todos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.primary
                              : AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Horizontal book list
              SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.nearbyBooks.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = controller.nearbyBooks[index];
                    return _buildBookCard(book, isDark);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book, bool isDark) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover
          Container(
            height: 168,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(book['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      book['distance'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Book info
          Text(
            book['title'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textLight : AppColors.textMain,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            book['author'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.token, color: AppColors.primary, size: 14),
              const SizedBox(width: 4),
              Text(
                '${book['credits']} Créditos',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityActivity(BuildContext context, bool isDark) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atividade da Comunidade',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textMain,
                ),
              ),
              const SizedBox(height: 16),
              ...controller.communityActivities.map((activity) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (isDark ? Colors.white : Colors.black).withOpacity(
                        0.05,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: activity['color'].withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          activity['icon'],
                          color: activity['color'],
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['text'],
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.textLight
                                    : AppColors.textMain,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${activity['time']} • ${activity['location']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.textMutedLight
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}

// Custom painter for map pin triangle
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
