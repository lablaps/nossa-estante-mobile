import 'package:flutter/material.dart';

/// Espaçamentos padronizados do aplicativo Nossa Estante

class AppSpacing {
  AppSpacing._();

  // ========== ESPAÇAMENTOS VERTICAIS/HORIZONTAIS ==========

  /// Extra pequeno: 4px
  /// Uso: Espaçamentos mínimos entre elementos muito próximos
  static const double xs = 4.0;

  /// Pequeno: 8px
  /// Uso: Espaçamento entre ícones e textos, elementos relacionados
  static const double sm = 8.0;

  /// Médio: 16px (padrão mais comum)
  /// Uso: Espaçamento entre seções, elementos de formulário
  static const double md = 16.0;

  /// Grande: 24px
  /// Uso: Espaçamento entre seções grandes, padding de páginas
  static const double lg = 24.0;

  /// Extra grande: 32px
  /// Uso: Espaçamento entre blocos principais
  static const double xl = 32.0;

  /// Extra extra grande: 48px
  /// Uso: Espaçamento em headers, seções de destaque
  static const double xxl = 48.0;

  /// Gigante: 64px
  /// Uso: Espaçamentos especiais, topo de páginas
  static const double xxxl = 64.0;

  // ========== PADDINGS PRÉ-DEFINIDOS ==========

  /// Padding padrão de página (16px todos os lados)
  static const EdgeInsets paddingPage = EdgeInsets.all(md);

  /// Padding de card/container (12px todos os lados)
  static const EdgeInsets paddingCard = EdgeInsets.all(12.0);

  /// Padding de seção (16px horizontal, 8px vertical)
  static const EdgeInsets paddingSection = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  /// Padding de botão (20px horizontal, 16px vertical)
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: md,
  );

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

  /// Padding de header (16px horizontal, 32px topo, 24px baixo)
  static const EdgeInsets paddingHeader = EdgeInsets.fromLTRB(md, xl, md, lg);

  /// Padding de badge/tag (12px horizontal, 6px vertical)
  static const EdgeInsets paddingBadge = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );

  /// Padding de ícone de busca (12px horizontal)
  static const EdgeInsets paddingSearchIcon = EdgeInsets.symmetric(
    horizontal: 12.0,
  );

  /// Padding de info badge do mapa (12px horizontal, 6px vertical)
  static const EdgeInsets paddingMapInfo = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );

  /// Margin de card de atividade (bottom 12px)
  static const EdgeInsets marginActivityCard = EdgeInsets.only(bottom: 12.0);

  /// Margin de seção de mapa (top 16px)
  static const EdgeInsets marginMapSection = EdgeInsets.only(top: md);

  /// Margin de seção de livros (top 8px)
  static const EdgeInsets marginBooksSection = EdgeInsets.only(top: sm);

  /// Padding vertical de seção de livros (24px)
  static const EdgeInsets paddingBooksSection = EdgeInsets.symmetric(
    vertical: lg,
  );

  /// Padding inferior para navegação (80px)
  static const double bottomNavPadding = 80.0;

  /// Padding zero (sem padding)
  static const EdgeInsets paddingZero = EdgeInsets.zero;

  /// Padding de badge de distância/overlay (8px horizontal, 4px vertical)
  static const EdgeInsets paddingDistanceBadge = EdgeInsets.symmetric(
    horizontal: sm,
    vertical: xs,
  );

  /// Padding de filtros/chips (16px horizontal, 8px vertical)
  static const EdgeInsets paddingChip = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  /// Padding all grande (24px)
  static const EdgeInsets paddingAllLG = EdgeInsets.all(lg);

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
