import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class PhotoUploadSection extends StatelessWidget {
  final List<String> photos;
  final VoidCallback onAddPhoto;
  final void Function(int) onRemovePhoto;

  const PhotoUploadSection({
    super.key,
    required this.photos,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Fotos Reais do Livro',
          style: AppTextStyles.labelMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.verticalSM,

        // Photo grid
        SizedBox(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Add photo button
              _buildAddPhotoButton(context),
              AppSpacing.horizontalSM,

              // Photo placeholders
              ...List.generate(3, (index) {
                if (index < photos.length) {
                  return Padding(
                    padding: EdgeInsets.only(right: AppSpacing.sm),
                    child: _buildPhotoTile(context, photos[index], index),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(right: AppSpacing.sm),
                  child: _buildEmptyPhotoTile(context),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return GestureDetector(
      onTap: onAddPhoto,
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: AppDimensions.borderRadiusSM,
          color: AppColors.primary.withValues(alpha: 0.05),
        ),
        child: Icon(
          Icons.add_a_photo,
          color: AppColors.primary,
          size: AppDimensions.iconXL,
        ),
      ),
    );
  }

  Widget _buildPhotoTile(BuildContext context, String photoUrl, int index) {
    return Stack(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: AppDimensions.borderRadiusSM,
            border: Border.all(color: context.borderColor),
            color: context.surfaceColor,
            image: DecorationImage(
              image: NetworkImage(photoUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemovePhoto(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.white,
                size: AppDimensions.iconSM,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPhotoTile(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusSM,
        border: Border.all(color: context.borderColor),
        color: context.surfaceColor,
      ),
      child: Icon(
        Icons.image_outlined,
        color: context.borderColor,
        size: AppDimensions.iconXL,
      ),
    );
  }
}
