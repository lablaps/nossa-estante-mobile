import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../add_book_controller.dart';

class AddBookActions extends StatelessWidget {
  final AddBookController controller;

  const AddBookActions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(top: BorderSide(color: context.borderColor, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppDimensions.opacityVeryLow,
            ),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: PrimaryButton(
          text: 'Adicionar à Estante',
          icon: Icons.add_circle,
          onPressed: controller.onSaveBook,
          isLoading: controller.isLoading,
        ),
      ),
    );
  }
}
