import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/distance_formatter.dart';
import '../../../core/widgets/widgets.dart';
import '../home_controller.dart';

/// Seção de atividades da comunidade
///
/// Recebe [Exchange] de domínio e faz conversão visual
class CommunityActivitySection extends StatelessWidget {
  const CommunityActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Padding(
          padding: AppSpacing.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Atividade da Comunidade'),
              AppSpacing.verticalMD,
              if (controller.isLoading)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                )
              else if (controller.communityActivities.isEmpty)
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
                ...controller.communityActivities.map((exchange) {
                  return _ActivityCard(exchange: exchange);
                }),
            ],
          ),
        );
      },
    );
  }
}

/// Card de atividade individual
///
/// Recebe [Exchange] e determina ícone, cor e texto baseado no status
class _ActivityCard extends StatelessWidget {
  final Exchange exchange;

  const _ActivityCard({required this.exchange});

  @override
  Widget build(BuildContext context) {
    final activityData = exchange.getVisualData();

    return GestureDetector(
      onTap: () {
        final controller = context.read<HomeController>();
        controller.onActivityTap(exchange);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
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
                color: activityData.color.withOpacity(
                  AppDimensions.opacityLow,
                ),
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
                    '${exchange.getTimeAgo()} • ${_formatLocation(context, exchange)}',
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

  /// Formata localização baseado na distância
  String _formatLocation(BuildContext context, Exchange exchange) {
    final controller = context.read<HomeController>();
    final currentUserLocation = controller.currentUser.location;
    final ownerLocation = exchange.owner.location;

    return DistanceFormatter.formatWithDescription(
      currentUserLocation,
      ownerLocation,
      fallback: exchange.meetingLocation ?? 'Local não definido',
    );
  }
}
