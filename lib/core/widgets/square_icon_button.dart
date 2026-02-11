import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Botão de ícone customizado quadrado com bordas arredondadas
///
/// Usado para filtros, menus e outras ações secundárias.
/// Mantém consistência visual através da aplicação.
class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  const SquareIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 46,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (context.isDark ? AppColors.slate800 : AppColors.white),
          borderRadius: AppDimensions.borderRadiusMD,
          border: Border.all(
            color:
                borderColor ??
                (context.isDark ? AppColors.slate600 : AppColors.slate200),
            width: 1,
          ),
        ),
        child: Icon(icon, color: iconColor ?? context.textColor),
      ),
    );
  }
}
