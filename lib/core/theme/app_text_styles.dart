import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Estilos de texto padronizados do aplicativo Nossa Estante

class AppTextStyles {
  AppTextStyles._();

  // ========== HEADINGS ==========

  /// Título extra grande (32px, weight 800)
  /// Uso: Títulos principais de páginas
  static TextStyle h1(BuildContext context) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.2,
      color: _textColor(context),
    );
  }

  /// Título grande (28px, weight 800)
  /// Uso: Títulos de seções importantes
  static TextStyle h2(BuildContext context) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      height: 1.2,
      color: _textColor(context),
    );
  }

  /// Título médio (24px, weight 700)
  /// Uso: Subtítulos e títulos de cards
  static TextStyle h3(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.2,
      color: _textColor(context),
    );
  }

  /// Título pequeno (20px, weight 700)
  /// Uso: Títulos de componentes menores
  static TextStyle h4(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.3,
      color: _textColor(context),
    );
  }

  /// Título extra pequeno (18px, weight 700)
  /// Uso: Subtítulos de cards
  static TextStyle h5(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.3,
      color: _textColor(context),
    );
  }

  /// Título mínimo (16px, weight 600)
  /// Uso: Labels de formulários
  static TextStyle h6(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: _textColor(context),
    );
  }

  // ========== BODY TEXT ==========

  /// Texto de corpo grande (16px, weight 500)
  /// Uso: Textos principais com destaque
  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: _textColor(context),
    );
  }

  /// Texto de corpo médio (14px, weight 500)
  /// Uso: Textos comuns, descrições
  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: _textColor(context),
    );
  }

  /// Texto de corpo pequeno (12px, weight 500)
  /// Uso: Textos secundários, metadados
  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: _textMutedColor(context),
    );
  }

  /// Texto extra pequeno (10px, weight 500)
  /// Uso: Labels de navegação, badges
  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: _textMutedColor(context),
    );
  }

  // ========== LABELS ==========

  /// Label grande (14px, weight 600)
  /// Uso: Labels de inputs
  static TextStyle labelLarge(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: _textColor(context),
    );
  }

  /// Label médio (12px, weight 600)
  /// Uso: Labels auxiliares
  static TextStyle labelMedium(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: _textColor(context),
    );
  }

  /// Label pequeno (11px, weight 600)
  /// Uso: Informações terciárias
  static TextStyle labelSmall(BuildContext context) {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: _textMutedColor(context),
    );
  }

  // ========== BUTTONS ==========

  /// Estilo de botão grande (18px, weight 700)
  /// Uso: Botões primários
  static TextStyle buttonLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
    );
  }

  /// Estilo de botão médio (16px, weight 700)
  /// Uso: Botões secundários
  static TextStyle buttonMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
    );
  }

  /// Estilo de botão pequeno (14px, weight 800)
  /// Uso: Botões compactos (Skip, etc)
  static TextStyle buttonSmall(BuildContext context) {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w800);
  }

  // ========== HELPERS PRIVADOS ==========

  /// Cor de texto principal (adapta ao tema)
  static Color _textColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textLight : AppColors.textMain;
  }

  /// Cor de texto secundário/muted (adapta ao tema)
  static Color _textMutedColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textMutedLight : AppColors.textMuted;
  }
}
