import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Item de navegação para bottom navigation bar

class NavItem extends StatelessWidget {
  /// Ícone preenchido (exibido quando ativo)
  final IconData icon;

  /// Ícone outlined (exibido quando inativo)
  final IconData iconOutlined;

  /// Label do item
  final String label;

  /// Se o item está ativo/selecionado
  final bool isActive;

  /// Callback ao tocar no item
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.iconOutlined,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? icon : iconOutlined,
              size: 26,
              color: isActive ? AppColors.primary : context.textMuted,
            ),
            AppSpacing.verticalXS,
            Text(
              label,
              style: AppTextStyles.caption(context).copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? AppColors.primary : context.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
