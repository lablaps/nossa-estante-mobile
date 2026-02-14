import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class ExchangeSettingsSection extends StatelessWidget {
  final Widget locationSelector;

  const ExchangeSettingsSection({super.key, required this.locationSelector});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider
        Container(
          height: 1,
          color: context.borderColor,
          margin: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        ),

        // Section header
        Row(
          children: [
            Icon(
              Icons.settings_suggest,
              color: AppColors.primary,
              size: AppDimensions.iconMD,
            ),
            AppSpacing.horizontalSM,
            Text('Configurações de Troca', style: AppTextStyles.h5(context)),
          ],
        ),
        AppSpacing.verticalLG,

        // Location selector
        locationSelector,
      ],
    );
  }
}
