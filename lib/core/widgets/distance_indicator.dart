import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Indicador de distância reutilizável
///
/// Exibe um badge com ícone de localização e texto de distância.
/// Usado para mostrar proximidade de livros ou usuários.
class DistanceIndicator extends StatelessWidget {
  final String distance;
  final Color? backgroundColor;
  final Color? textColor;

  const DistanceIndicator({
    super.key,
    required this.distance,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.black.withOpacity(0.6),
        borderRadius: AppDimensions.borderRadiusSM,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, size: 12, color: textColor ?? Colors.white),
          const SizedBox(width: 4),
          Text(
            distance,
            style: AppTextStyles.caption(context).copyWith(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
