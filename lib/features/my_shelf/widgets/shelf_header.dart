import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Header da página My Shelf com título e ícone de notificações
class ShelfHeader extends StatelessWidget {
  const ShelfHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Shelf',
            style: AppTextStyles.h2(context).copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implementar navegação para notificações
            },
            icon: const Icon(Icons.notifications_outlined),
            color: context.textColor,
            padding: const EdgeInsets.all(AppSpacing.sm),
            constraints: const BoxConstraints(),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}
