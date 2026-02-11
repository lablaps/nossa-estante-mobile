import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Widget genérico para exibir estado de erro
///
/// Centraliza o padrão de erro com ícone e mensagem.
/// Opcionalmente pode incluir botão de retry.
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool useScaffold;
  final Color? backgroundColor;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.useScaffold = true,
    this.backgroundColor,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: context.isDark ? AppColors.slate600 : AppColors.slate400,
            ),
            AppSpacing.verticalMD,
            Text(
              message,
              style: AppTextStyles.bodyMedium(context),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              AppSpacing.verticalLG,
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (useScaffold) {
      return Scaffold(
        backgroundColor: backgroundColor ?? context.backgroundColor,
        body: content,
      );
    }

    return content;
  }
}
