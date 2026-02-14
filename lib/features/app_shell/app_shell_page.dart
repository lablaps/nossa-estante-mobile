import 'package:flutter/material.dart';
import 'package:nossa_estante_mobile/features/my_shelf/my_shelf_page.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
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

class _AppShellView extends StatefulWidget {
  const _AppShellView();

  @override
  State<_AppShellView> createState() => _AppShellViewState();
}

class _AppShellViewState extends State<_AppShellView> {
  // Páginas/telas do app
  static final List<Widget> _pages = [
    const HomePage(),
    const MyShelfPage(),
    const _PlaceholderPage(title: 'Adicionar', icon: Icons.add),
    const _PlaceholderPage(title: 'Trocas', icon: Icons.swap_horiz),
    const _PlaceholderPage(title: 'Perfil', icon: Icons.person),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<AppShellController>();

    // Handle navigation
    if (controller.pendingNavigation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final navigation = controller.pendingNavigation;
        if (navigation != null && mounted) {
          controller.clearNavigation();
          if (navigation.isPush && navigation.route != null) {
            Navigator.pushNamed(
              context,
              navigation.route!,
              arguments: navigation.arguments,
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Previne voltar para o login
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {}
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
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(top: BorderSide(color: context.borderColor)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItem(
            icon: Icons.home,
            iconOutlined: Icons.home_outlined,
            label: 'Início',
            isActive: controller.currentIndex == 0,
            onTap: () => controller.setIndex(0),
          ),
          NavItem(
            icon: Icons.auto_stories,
            iconOutlined: Icons.auto_stories_outlined,
            label: 'Estante',
            isActive: controller.currentIndex == 1,
            onTap: () => controller.setIndex(1),
          ),
          CentralAddButton(
            isActive: controller.currentIndex == 2,
            onTap: () => controller.setIndex(2),
          ),
          NavItem(
            icon: Icons.chat,
            iconOutlined: Icons.chat_outlined,
            label: 'Trocas',
            isActive: controller.currentIndex == 3,
            onTap: () => controller.setIndex(3),
          ),
          NavItem(
            icon: Icons.person,
            iconOutlined: Icons.person_outline,
            label: 'Perfil',
            isActive: controller.currentIndex == 4,
            onTap: () => controller.setIndex(4),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: context.surfaceColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
            AppSpacing.verticalLG,
            Text(title, style: AppTextStyles.h3(context)),
            AppSpacing.verticalXS,
            Text(
              'Em desenvolvimento',
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(color: context.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
