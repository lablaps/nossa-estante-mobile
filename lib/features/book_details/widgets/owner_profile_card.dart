import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

class OwnerProfileCard extends StatelessWidget {
  final User owner;
  final VoidCallback? onMessageTap;

  const OwnerProfileCard({super.key, required this.owner, this.onMessageTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.white.withValues(alpha: AppDimensions.opacityVeryLow)
            : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.borderDark
              : AppColors.grayBorder, // gray-100
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppDimensions.opacityVeryLow,
            ),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          _buildAvatar(context),
          AppSpacing.horizontalMD,

          // Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Propriedade de',
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: context.isDark
                        ? AppColors
                              .captionText // gray-400
                        : const Color(0xFF6B7280), // gray-500
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  owner.name,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 4),
                _buildRating(context),
              ],
            ),
          ),

          // Botão de mensagem
          IconButton(
            onPressed: onMessageTap,
            icon: const Icon(Icons.chat_bubble_outline),
            style: IconButton.styleFrom(
              backgroundColor: isDark
                  ? AppColors.surfaceDark
                  : AppColors.backgroundLight,
              foregroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        // Avatar do usuário
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.slate200,
            image: owner.avatarUrl != null
                ? DecorationImage(
                    image: NetworkImage(owner.avatarUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: owner.avatarUrl == null
              ? Center(
                  child: Text(
                    owner.name[0].toUpperCase(),
                    style: AppTextStyles.h4(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                )
              : null,
        ),

        // Badge PRO (pode ser adicionado ao User)
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
              border: Border.all(color: context.surfaceColor, width: 2),
            ),
            child: Text(
              'PRO',
              style: AppTextStyles.caption(context).copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    // Simulando rating (pode ser adicionado ao User)
    return Row(
      children: [
        const Icon(Icons.star, size: 14, color: Color(0xFFFBBF24)),
        const SizedBox(width: 4),
        Text(
          '4.8',
          style: AppTextStyles.bodySmall(
            context,
          ).copyWith(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          '(124 Trocas)',
          style: AppTextStyles.caption(context).copyWith(
            color: AppColors.captionText, // gray-400
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
