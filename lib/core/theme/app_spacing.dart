import 'package:flutter/material.dart';

/// Espaçamentos padronizados do aplicativo Nossa Estante

class AppSpacing {
  AppSpacing._();

  // ========== ESPAÇAMENTOS VERTICAIS/HORIZONTAIS ==========

  /// Extra pequeno: 4px
  static const double xs = 4.0;

  /// Pequeno: 8px
  static const double sm = 8.0;

  /// Médio: 16px (padrão)
  static const double md = 16.0;

  /// Grande: 24px
  static const double lg = 24.0;

  /// Extra grande: 32px
  static const double xl = 32.0;

  /// Extra extra grande: 48px
  static const double xxl = 48.0;

  /// Gigante: 64px
  static const double xxxl = 64.0;

  // ========== PADDINGS PRÉ-DEFINIDOS ==========

  /// Padding padrão de página (16px todos os lados)
  static const EdgeInsets paddingPage = EdgeInsets.all(md);

  /// Padding de card/container (12px todos os lados)
  static const EdgeInsets paddingCard = EdgeInsets.all(12.0);

  /// Padding horizontal padrão (24px)
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: lg,
  );

  /// Padding vertical padrão (16px)
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: md);

  /// Padding de formulário (24px horizontal, 16px vertical)
  static const EdgeInsets paddingForm = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  /// Padding de badge/tag (12px horizontal, 6px vertical)
  static const EdgeInsets paddingBadge = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );

  /// Padding inferior para navegação (80px)
  static const double bottomNavPadding = 80.0;

  /// Padding zero (sem padding)
  static const EdgeInsets paddingZero = EdgeInsets.zero;

  // ========== WIDGETS DE ESPAÇAMENTO ==========

  /// SizedBox vertical extra pequeno (4px)
  static const Widget verticalXS = SizedBox(height: xs);

  /// SizedBox vertical pequeno (8px)
  static const Widget verticalSM = SizedBox(height: sm);

  /// SizedBox vertical médio (16px)
  static const Widget verticalMD = SizedBox(height: md);

  /// SizedBox vertical grande (24px)
  static const Widget verticalLG = SizedBox(height: lg);

  /// SizedBox vertical extra grande (32px)
  static const Widget verticalXL = SizedBox(height: xl);

  /// SizedBox vertical extra extra grande (48px)
  static const Widget verticalXXL = SizedBox(height: xxl);

  /// SizedBox horizontal extra pequeno (4px)
  static const Widget horizontalXS = SizedBox(width: xs);

  /// SizedBox horizontal pequeno (8px)
  static const Widget horizontalSM = SizedBox(width: sm);

  /// SizedBox horizontal médio (16px)
  static const Widget horizontalMD = SizedBox(width: md);

  /// SizedBox horizontal grande (24px)
  static const Widget horizontalLG = SizedBox(width: lg);

  /// SizedBox horizontal extra grande (32px)
  static const Widget horizontalXL = SizedBox(width: xl);
}
