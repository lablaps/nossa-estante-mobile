import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../theme/theme_extensions.dart';

/// Header compartilhado para páginas de autenticação (Login e Signup)

class AuthHeader extends StatelessWidget {
  /// Título principal (ex: "Bem-vindo de volta")
  final String title;

  /// Subtítulo/descrição (ex: "Faça login para continuar")
  final String subtitle;

  /// Ícone exibido no círculo (padrão: livro)
  final IconData icon;

  /// Tamanho do container circular do ícone (padrão: 96)
  final double iconContainerSize;

  /// Tamanho do ícone interno (padrão: 48)
  final double iconSize;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.menu_book_rounded,
    this.iconContainerSize = 96.0,
    this.iconSize = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xxl,
        bottom: AppSpacing.lg,
        left: AppSpacing.md,
        right: AppSpacing.md,
      ),
      child: Column(
        children: [
          // Logo/Ícone circular
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: iconSize, color: AppColors.primary),
          ),
          AppSpacing.verticalLG,

          // Título
          Text(
            title,
            style: AppTextStyles.h1(context),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSM,

          // Subtítulo
          Text(
            subtitle,
            style: AppTextStyles.bodyLarge(
              context,
            ).copyWith(color: context.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
