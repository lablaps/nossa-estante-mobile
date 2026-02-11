import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Dimensões padronizadas do aplicativo Nossa Estante

class AppDimensions {
  AppDimensions._();

  // ========== BORDER RADIUS ==========

  /// Raio extra pequeno: 8px
  /// Uso: Pequenos detalhes, badges
  static const double radiusXS = 8.0;

  /// Raio pequeno: 12px
  /// Uso: Cards pequenos, chips
  static const double radiusSM = 12.0;

  /// Raio médio: 16px (padrão)
  /// Uso: Cards, inputs, containers
  static const double radiusMD = 16.0;

  /// Raio grande: 24px
  /// Uso: Modais, seções destacadas
  static const double radiusLG = 24.0;

  /// Raio extra grande: 28px
  /// Uso: Botões de login social, avatares
  static const double radiusXL = 28.0;

  /// Raio círculo completo: 9999px
  /// Uso: Botões circulares, tags arredondadas
  static const double radiusFull = 9999.0;

  // ========== BORDER RADIUS PRÉ-DEFINIDOS ==========

  /// BorderRadius pequeno (12px)
  static final BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);

  /// BorderRadius médio (16px)
  static final BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);

  /// BorderRadius grande (24px)
  static final BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);

  /// BorderRadius extra grande (28px)
  static final BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);

  /// BorderRadius circular completo (9999px)
  static final BorderRadius borderRadiusFull = BorderRadius.circular(
    radiusFull,
  );

  // ========== TAMANHOS DE COMPONENTES ==========

  /// Altura padrão de botões: 56px
  static const double buttonHeight = 56.0;

  /// Altura padrão de inputs: 56px
  static const double inputHeight = 56.0;

  /// Tamanho de botão circular pequeno: 48px
  static const double buttonCircularSmall = 48.0;

  /// Tamanho de botão circular médio: 56px
  static const double buttonCircularMedium = 56.0;

  /// Tamanho de botão circular grande: 64px
  static const double buttonCircularLarge = 64.0;

  /// Tamanho de avatar pequeno: 32px
  static const double avatarSmall = 32.0;

  /// Tamanho de avatar médio: 40px
  static const double avatarMedium = 40.0;

  /// Tamanho de avatar grande: 96px
  static const double avatarLarge = 96.0;

  /// Largura máxima de conteúdo mobile: 600px
  static const double maxContentWidth = 600.0;

  // ========== TAMANHOS DE ÍCONES ==========

  /// Ícone extra pequeno: 16px
  static const double iconXS = 16.0;

  /// Ícone pequeno: 20px
  static const double iconSM = 20.0;

  /// Ícone médio: 24px
  static const double iconMD = 24.0;

  /// Ícone grande: 28px
  static const double iconLG = 28.0;

  /// Ícone extra grande: 32px
  static const double iconXL = 32.0;

  /// Ícone gigante: 48px
  static const double iconXXL = 48.0;

  // ========== ELEVAÇÕES (SHADOWS) ==========

  /// Sombra nível 1 (baixa)
  static const double elevationLow = 2.0;

  /// Sombra nível 2 (média)
  static const double elevationMedium = 4.0;

  /// Sombra nível 3 (alta)
  static const double elevationHigh = 8.0;

  /// Sombra nível 4 (muito alta)
  static const double elevationVeryHigh = 16.0;

  // ========== LARGURAS DE BORDA ==========

  /// Borda fina: 1px
  static const double borderThin = 1.0;

  /// Borda média: 1.5px
  static const double borderMedium = 1.5;

  /// Borda grossa: 2px
  static const double borderThick = 2.0;

  // ========== OPACIDADES ==========

  /// Opacidade muito baixa: 0.05 (5%)
  /// Uso: Overlays sutis, backgrounds muito leves
  static const double opacityVeryLow = 0.05;

  /// Opacidade baixa: 0.1 (10%)
  /// Uso: Backgrounds sutis, overlays leves
  static const double opacityLow = 0.1;

  /// Opacidade média-baixa: 0.2 (20%)
  /// Uso: Shadows leves, borders suaves
  static const double opacityMediumLow = 0.2;

  /// Opacidade média: 0.3 (30%)
  /// Uso: Shadows, borders, elementos secundários
  static const double opacityMedium = 0.3;

  /// Opacidade média-alta: 0.5 (50%)
  /// Uso: Elementos desabilitados, overlays médios
  static const double opacityMediumHigh = 0.5;

  /// Opacidade alta: 0.6 (60%)
  /// Uso: Textos desabilitados, placeholders
  static const double opacityHigh = 0.6;

  /// Opacidade muito alta: 0.9 (90%)
  /// Uso: Overlays semi-opacos, elementos quase sólidos
  static const double opacityVeryHigh = 0.9;

  // ========== BOX SHADOWS PRÉ-DEFINIDAS ==========

  /// Sombra para cards e containers elevados
  static final List<BoxShadow> shadowCard = [
    BoxShadow(
      color: AppColors.overlayLight,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Sombra para botões e elementos interativos
  static final List<BoxShadow> shadowButton = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  /// Sombra para elementos flutuantes (FAB, bottom sheets)
  static final List<BoxShadow> shadowFloating = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Sombra elevada para seções destacadas
  static final List<BoxShadow> shadowElevated = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 20,
      offset: const Offset(0, -5),
    ),
  ];

  /// Sombra com glow (para elementos primários)
  static List<BoxShadow> shadowGlow(Color color) => [
    BoxShadow(
      color: color.withOpacity(opacityMedium),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}
