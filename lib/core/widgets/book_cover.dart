import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'book_placeholder.dart';

/// Widget reutilizável para exibir capa de livro
///
/// Fonte única de verdade para renderização de capas.
/// Usa coverUrl quando disponível, caso contrário mostra placeholder.
class BookCover extends StatelessWidget {
  final String? coverUrl;
  final double width;
  final double height;
  final String? fallbackText;
  final BorderRadius? borderRadius;

  const BookCover({
    super.key,
    this.coverUrl,
    required this.width,
    required this.height,
    this.fallbackText,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Se não tem coverUrl, usa placeholder
    if (coverUrl == null || coverUrl!.isEmpty) {
      return BookPlaceholder(width: width, height: height, text: fallbackText);
    }

    return ClipRRect(
      borderRadius: borderRadius ?? AppDimensions.borderRadiusMD,
      child: Image.network(
        coverUrl!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Em caso de erro ao carregar, usa placeholder
          return BookPlaceholder(
            width: width,
            height: height,
            text: fallbackText,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          // Mostra placeholder durante carregamento
          return BookPlaceholder(
            width: width,
            height: height,
            text: fallbackText,
          );
        },
      ),
    );
  }
}
