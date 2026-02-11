import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

/// Extensões convenientes para acesso rápido a propriedades do tema

extension ThemeX on BuildContext {
  /// Verifica se o tema atual é escuro
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Verifica se o tema atual é claro
  bool get isLight => Theme.of(this).brightness == Brightness.light;

  // ========== CORES DE TEXTO ==========

  /// Cor de texto principal (adapta ao tema)
  Color get textColor => isDark ? AppColors.textLight : AppColors.textMain;

  /// Cor de texto secundário/muted (adapta ao tema)
  Color get textMuted =>
      isDark ? AppColors.textMutedLight : AppColors.textMuted;

  // ========== CORES DE SUPERFÍCIE ==========

  /// Cor de fundo principal da tela (adapta ao tema)
  Color get backgroundColor =>
      isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

  /// Cor de superfície de cards/containers (adapta ao tema)
  Color get surfaceColor =>
      isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

  // ========== CORES DE INPUT ==========

  /// Cor de fundo de inputs (adapta ao tema)
  Color get inputBackground =>
      isDark ? AppColors.inputBackgroundDark : AppColors.inputBackgroundLight;

  /// Cor de borda de inputs (adapta ao tema)
  Color get borderColor =>
      isDark ? AppColors.borderDark : AppColors.borderLight;

  // ========== OVERLAYS E SOMBRAS ==========

  /// Overlay suave para bordas e divisórias (adapta ao tema)
  Color get overlay => (isDark ? AppColors.white : AppColors.black).withOpacity(
    AppDimensions.opacityVeryLow,
  );

  /// Overlay médio (adapta ao tema)
  Color get overlayMedium => (isDark ? AppColors.white : AppColors.black)
      .withOpacity(AppDimensions.opacityLow);

  /// Sombra padrão
  Color get shadow => AppColors.black.withOpacity(AppDimensions.opacityLow);

  /// Sombra suave
  Color get shadowSoft =>
      AppColors.black.withOpacity(AppDimensions.opacityVeryLow);

  /// Sombra forte
  Color get shadowStrong =>
      AppColors.black.withOpacity(AppDimensions.opacityMediumLow);

  // ========== CORES PRIMÁRIAS ==========

  /// Cor primária (sempre verde, não muda com tema)
  Color get primaryColor => AppColors.primary;

  /// Cor primária escura
  Color get primaryDark => AppColors.primaryDark;
}
