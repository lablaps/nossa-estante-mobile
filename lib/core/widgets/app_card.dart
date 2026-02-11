import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Card padrão reutilizável da aplicação
///
/// Container com bordas arredondadas, borda e sombra padronizadas.
/// Use para manter consistência visual em cards, containers elevados, etc.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? AppSpacing.paddingCard,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.surfaceColor,
        borderRadius: borderRadius ?? AppDimensions.borderRadiusMD,
        border: border ?? Border.all(color: context.borderColor),
        boxShadow: boxShadow ?? AppDimensions.shadowCard,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
