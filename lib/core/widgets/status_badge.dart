import 'package:flutter/material.dart';
import '../domain/entities/entities.dart';
import '../theme/theme.dart';

/// Badge para exibir o status de um livro
///
/// Cores baseadas no status: available (verde), inExchange (amarelo), unavailable (cinza).
class StatusBadge extends StatelessWidget {
  final BookStatus status;
  final double? fontSize;
  final EdgeInsets? padding;

  const StatusBadge({
    super.key,
    required this.status,
    this.fontSize,
    this.padding,
  });

  Color get _backgroundColor {
    switch (status) {
      case BookStatus.available:
        return AppColors.primary;
      case BookStatus.inExchange:
        return const Color(0xFFFBBF24); // Amber
      case BookStatus.unavailable:
        return AppColors.slate400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: AppDimensions.borderRadiusFull,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: AppColors.slate900,
          fontSize: fontSize ?? 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
