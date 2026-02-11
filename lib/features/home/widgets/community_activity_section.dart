import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/mocks/mocks.dart';
import '../../../core/theme/theme.dart';
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
              Text('Atividade da Comunidade', style: AppTextStyles.h3(context)),
              AppSpacing.verticalMD,
              if (controller.isLoading)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                )
              else if (controller.communityActivities.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
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
    // Conversão domínio → visual
    final activityData = _getActivityData(exchange);

    return GestureDetector(
      onTap: () {
        final controller = context.read<HomeController>();
        controller.onActivityTap(exchange);
      },
      child: Container(
        margin: AppSpacing.marginActivityCard,
        padding: AppSpacing.paddingCard,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: AppDimensions.borderRadiusMD,
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
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
                color: activityData.color.withOpacity(0.2),
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

  /// Determina dados visuais baseado no status da troca
  _ActivityData _getActivityData(Exchange exchange) {
    switch (exchange.status) {
      case ExchangeStatus.completed:
        return _ActivityData(
          icon: Icons.swap_horiz,
          color: const Color(0xFF13EC5B),
          text:
              '${exchange.requester.name} trocou um livro com ${exchange.owner.name}',
        );
      case ExchangeStatus.approved:
        return _ActivityData(
          icon: Icons.check_circle,
          color: Colors.blue,
          text:
              '${exchange.requester.name} vai trocar com ${exchange.owner.name}',
        );
      case ExchangeStatus.pending:
        return _ActivityData(
          icon: Icons.pending,
          color: Colors.orange,
          text: '${exchange.requester.name} solicitou "${exchange.book.title}"',
        );
      case ExchangeStatus.cancelled:
        return _ActivityData(
          icon: Icons.cancel,
          color: Colors.grey,
          text: 'Troca de "${exchange.book.title}" cancelada',
        );
    }
  }

  /// Formata localização baseado na distância
  String _formatLocation(Exchange exchange) {
    final currentUserLocation = MockUsers.currentUser.location;
    final ownerLocation = exchange.owner.location;

    if (currentUserLocation == null || ownerLocation == null) {
      return exchange.meetingLocation ?? 'Local não definido';
    }

    final distanceKm = currentUserLocation.distanceTo(ownerLocation);

    if (distanceKm < 1) {
      return 'Perto';
    } else if (distanceKm < 5) {
      return '${distanceKm.toStringAsFixed(1)}km de distância';
    } else {
      return 'Longe';
    }
  }
}

/// Dados visuais de uma atividade
class _ActivityData {
  final IconData icon;
  final Color color;
  final String text;

  _ActivityData({required this.icon, required this.color, required this.text});
}
