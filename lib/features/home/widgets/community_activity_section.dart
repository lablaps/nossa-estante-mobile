import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/distance_formatter.dart';
import '../../../core/widgets/widgets.dart';

// Atividades da comunidade
class CommunityActivitySection extends StatelessWidget {
  final List<Exchange> communityActivities;
  final User currentUser;
  final bool isLoading;
  final ValueChanged<Exchange>? onActivityTap;

  const CommunityActivitySection({
    super.key,
    required this.communityActivities,
    required this.currentUser,
    required this.isLoading,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Atividade da Comunidade'),
          AppSpacing.verticalMD,
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (communityActivities.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Nenhuma atividade recente',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: context.textMuted),
                ),
              ),
            )
          else
            ...communityActivities.map((exchange) {
              return _ActivityCard(
                exchange: exchange,
                currentUser: currentUser,
                onTap: onActivityTap != null
                    ? () => onActivityTap!(exchange)
                    : null,
              );
            }),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Exchange exchange;
  final User currentUser;
  final VoidCallback? onTap;

  const _ActivityCard({
    required this.exchange,
    required this.currentUser,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activityData = exchange.getVisualData();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: AppSpacing.paddingCard,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: AppDimensions.borderRadiusMD,
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: activityData.color.withOpacity(AppDimensions.opacityLow),
                shape: BoxShape.circle,
              ),
              child: Icon(
                activityData.icon,
                color: activityData.color,
                size: 20,
              ),
            ),
            AppSpacing.horizontalSM,
            AppSpacing.horizontalXS,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activityData.text,
                    style: AppTextStyles.bodyMedium(context),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${exchange.getTimeAgo()} • ${_formatLocation(exchange)}',
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(color: context.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatLocation(Exchange exchange) {
    final currentUserLocation = currentUser.location;
    final ownerLocation = exchange.owner.location;

    return DistanceFormatter.formatWithDescription(
      currentUserLocation,
      ownerLocation,
      fallback: exchange.meetingLocation ?? 'Local não definido',
    );
  }
}
