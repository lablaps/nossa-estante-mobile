import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../add_book_controller.dart';

class AddBookCoverPicker extends StatelessWidget {
  final AddBookController controller;

  const AddBookCoverPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capa do Livro (opcional)',
          style: AppTextStyles.labelLarge(context),
        ),
        AppSpacing.verticalSM,
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: context.inputBackground,
            borderRadius: AppDimensions.borderRadiusMD,
            border: Border.all(
              color: context.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          child: controller.coverUrl.isEmpty
              ? _buildPlaceholder(context)
              : _buildCoverPreview(context),
        ),
        AppSpacing.verticalSM,
        _buildUrlInput(context),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image_outlined,
          size: 64,
          color: context.textMuted.withOpacity(AppDimensions.opacityMedium),
        ),
        AppSpacing.verticalSM,
        Text(
          'Adicione uma URL de capa',
          style: AppTextStyles.bodyMedium(
            context,
          ).copyWith(color: context.textMuted),
        ),
      ],
    );
  }

  Widget _buildCoverPreview(BuildContext context) {
    return ClipRRect(
      borderRadius: AppDimensions.borderRadiusMD,
      child: Stack(
        children: [
          Image.network(
            controller.coverUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildPlaceholder(context),
          ),
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: GestureDetector(
              onTap: () => controller.setCoverUrl(''),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrlInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusMD,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        onChanged: controller.setCoverUrl,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: context.textColor),
        decoration: InputDecoration(
          hintText: 'Cole a URL da capa aqui',
          hintStyle: TextStyle(
            color: context.textMuted.withOpacity(AppDimensions.opacityHigh),
          ),
          filled: true,
          fillColor: context.inputBackground,
          border: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusMD,
            borderSide: BorderSide(color: context.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusMD,
            borderSide: BorderSide(color: context.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusMD,
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          prefixIcon: Icon(Icons.link, color: context.textMuted),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
