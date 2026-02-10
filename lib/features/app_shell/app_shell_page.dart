import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
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

  // Páginas/telas do app (placeholders por enquanto)
  static final List<Widget> _pages = [
    _PlaceholderPage(title: 'Início', icon: Icons.home),
    _PlaceholderPage(title: 'Explorar', icon: Icons.explore),
    _PlaceholderPage(title: 'Adicionar', icon: Icons.add),
    _PlaceholderPage(title: 'Trocas', icon: Icons.swap_horiz),
    _PlaceholderPage(title: 'Perfil', icon: Icons.person),
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
            bottomNavigationBar: _buildBottomNavigationBar(context, controller),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    AppShellController controller,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: controller.currentIndex,
      onTap: controller.setIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: isDark
          ? AppColors.textMutedLight.withOpacity(0.6)
          : AppColors.textMuted.withOpacity(0.6),
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 8,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline, size: 32),
          activeIcon: Icon(Icons.add_circle, size: 32),
          label: 'Adicionar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz_outlined),
          activeIcon: Icon(Icons.swap_horiz),
          label: 'Trocas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

/// Widget placeholder para as páginas
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderPage({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.primary.withOpacity(0.3),
            ),
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
