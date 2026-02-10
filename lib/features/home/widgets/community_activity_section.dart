import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../home_controller.dart';

/// Seção de atividades da comunidade
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
                ...controller.communityActivities.map((activity) {
                  return Container(
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
                            color: activity['color'].withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            activity['icon'],
                            color: activity['color'],
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
                                activity['text'],
                                style: AppTextStyles.bodyMedium(context),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${activity['time']} • ${activity['location']}',
                                style: AppTextStyles.bodySmall(
                                  context,
                                ).copyWith(color: context.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        );
      },
    );
  }
}
