import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Header da página principal do app
///
/// Exibe informações do usuário (avatar, nome), créditos
/// e título "Nossa Estante" com botão de notificações.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and credits
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Avatar
                  Container(
                    width: AppDimensions.avatarMedium,
                    height: AppDimensions.avatarMedium,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(
                        AppDimensions.opacityMediumLow,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(
                          AppDimensions.opacityMedium,
                        ),
                        width: AppDimensions.borderThick,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: AppDimensions.iconMD,
                    ),
                  ),
                  AppSpacing.horizontalSM,
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bem-vindo,',
                        style: AppTextStyles.bodySmall(context),
                      ),
                      Text(
                        'Sarah Jenkins',
                        style: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              _buildCreditsBadge(context),
            ],
          ),
          AppSpacing.verticalMD,

          // Title and notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nossa Estante', style: AppTextStyles.h2(context)),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: context.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreditsBadge(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingBadge,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(
          context.isDark
              ? AppDimensions.opacityMediumLow
              : AppDimensions.opacityLow,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(AppDimensions.opacityMedium),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.token,
            color: context.isDark ? AppColors.primary : AppColors.primaryDark,
            size: 18,
          ),
          AppSpacing.horizontalXS,
          Text(
            '12 Créditos',
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: FontWeight.bold,
              color: context.isDark ? AppColors.primary : AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
