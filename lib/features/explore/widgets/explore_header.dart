import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';

/// Header da página Explorar
///
/// Exibe título, subtítulo e avatar do usuário.
/// Não contém lógica de navegação.
class ExploreHeader extends StatelessWidget {
  final User user;

  const ExploreHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xxxl + AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explorar', style: AppTextStyles.h1(context)),
                AppSpacing.verticalXS,
                Text(
                  'Descubra novos livros e gêneros',
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: context.isDark
                        ? AppColors.slate400
                        : AppColors.slate600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: AppDimensions.avatarMedium,
            height: AppDimensions.avatarMedium,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(AppDimensions.opacityLow),
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
              border: Border.all(
                color: AppColors.primary.withOpacity(
                  AppDimensions.opacityMedium,
                ),
              ),
            ),
            child: user.avatarUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                    child: Image.network(
                      user.avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildAvatarFallback(context),
                    ),
                  )
                : _buildAvatarFallback(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback(BuildContext context) {
    return Center(
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
        style: AppTextStyles.h4(context).copyWith(color: AppColors.primary),
      ),
    );
  }
}
