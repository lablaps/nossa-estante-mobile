import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../home/home_page.dart';
import 'app_shell_controller.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppShellController(),
      child: const _AppShellView(),
    );
  }
}

class _AppShellView extends StatelessWidget {
  const _AppShellView();

  // Páginas/telas do app
  static final List<Widget> _pages = [
    const HomePage(),
    const _PlaceholderPage(title: 'Explorar', icon: Icons.explore),
    const _PlaceholderPage(title: 'Adicionar', icon: Icons.add),
    const _PlaceholderPage(title: 'Trocas', icon: Icons.swap_horiz),
    const _PlaceholderPage(title: 'Perfil', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Previne voltar para o login
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Opcional: mostrar diálogo de confirmação para sair do app
          // Por enquanto, não faz nada (impede voltar)
        }
      },
      child: Consumer<AppShellController>(
        builder: (context, controller, _) {
          return Scaffold(
            body: IndexedStack(
              index: controller.currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: _buildCustomBottomNav(context, controller),
          );
        },
      ),
    );
  }

  Widget _buildCustomBottomNav(
    BuildContext context,
    AppShellController controller,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        border: Border(
          top: BorderSide(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            iconOutlined: Icons.home_outlined,
            label: 'Início',
            isActive: controller.currentIndex == 0,
            onTap: () => controller.setIndex(0),
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            icon: Icons.map,
            iconOutlined: Icons.map_outlined,
            label: 'Explorar',
            isActive: controller.currentIndex == 1,
            onTap: () => controller.setIndex(1),
            isDark: isDark,
          ),
          _buildCentralAddButton(
            context,
            isActive: controller.currentIndex == 2,
            onTap: () => controller.setIndex(2),
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            icon: Icons.chat,
            iconOutlined: Icons.chat_outlined,
            label: 'Trocas',
            isActive: controller.currentIndex == 3,
            onTap: () => controller.setIndex(3),
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            iconOutlined: Icons.person_outline,
            label: 'Perfil',
            isActive: controller.currentIndex == 4,
            onTap: () => controller.setIndex(4),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData iconOutlined,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? icon : iconOutlined,
              size: 26,
              color: isActive
                  ? AppColors.primary
                  : isDark
                  ? AppColors.textMutedLight
                  : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive
                    ? AppColors.primary
                    : isDark
                    ? AppColors.textMutedLight
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralAddButton(
    BuildContext context, {
    required bool isActive,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -12),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -8),
            child: Text(
              'Adicionar',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget placeholder para as páginas
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderPage({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: AppColors.primary.withOpacity(0.3)),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: isDark ? AppColors.textLight : AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Em desenvolvimento',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
