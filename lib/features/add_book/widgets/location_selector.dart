import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class LocationSelector extends StatelessWidget {
  final VoidCallback onUseCurrentLocation;
  final VoidCallback onSelectOnMap;

  const LocationSelector({
    super.key,
    required this.onUseCurrentLocation,
    required this.onSelectOnMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Location',
          style: AppTextStyles.labelMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.verticalSM,

        // Buttons row
        Row(
          children: [
            // Use current location
            Expanded(
              child: _buildLocationButton(
                context,
                icon: Icons.my_location,
                label: 'Usar Atual',
                isPrimary: true,
                onTap: onUseCurrentLocation,
              ),
            ),
            AppSpacing.horizontalSM,

            // Select on map
            Expanded(
              child: _buildLocationButton(
                context,
                icon: Icons.map_outlined,
                label: 'Selecionar no Mapa',
                isPrimary: false,
                onTap: onSelectOnMap,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary.withValues(alpha: 0.1)
              : context.surfaceColor,
          border: Border.all(
            color: isPrimary ? AppColors.primary : context.borderColor,
          ),
          borderRadius: AppDimensions.borderRadiusSM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? AppColors.primary : context.textColor,
              size: AppDimensions.iconSM,
            ),
            AppSpacing.horizontalSM,
            Text(
              label,
              style: AppTextStyles.labelSmall(context).copyWith(
                fontWeight: FontWeight.w600,
                color: isPrimary ? AppColors.primary : context.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
