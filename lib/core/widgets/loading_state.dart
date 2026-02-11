import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Widget genérico para exibir estado de carregamento
///
/// Centraliza o padrão de loading com CircularProgressIndicator.
/// Usa Scaffold ou apenas Center dependendo se já está dentro de um Scaffold.
class LoadingState extends StatelessWidget {
  final bool useScaffold;
  final Color? backgroundColor;
  final Color? progressColor;

  const LoadingState({
    super.key,
    this.useScaffold = true,
    this.backgroundColor,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: CircularProgressIndicator(
        color: progressColor ?? AppColors.primary,
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
