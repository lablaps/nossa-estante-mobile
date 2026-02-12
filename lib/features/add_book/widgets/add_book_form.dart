import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../add_book_controller.dart';

class AddBookForm extends StatelessWidget {
  final AddBookController controller;

  const AddBookForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        CustomTextField(
          labelText: 'Título',
          hintText: 'Ex: O Alquimista',
          prefixIcon: Icons.book_outlined,
          onChanged: controller.setTitle,
        ),
        AppSpacing.verticalLG,

        // Autor
        CustomTextField(
          labelText: 'Autor',
          hintText: 'Ex: Paulo Coelho',
          prefixIcon: Icons.person_outline,
          onChanged: controller.setAuthor,
        ),
        AppSpacing.verticalLG,

        // ISBN (opcional)
        CustomTextField(
          labelText: 'ISBN (opcional)',
          hintText: 'Ex: 9788576651239',
          prefixIcon: Icons.numbers,
          keyboardType: TextInputType.number,
          onChanged: controller.setIsbn,
        ),
        AppSpacing.verticalLG,

        // Número de páginas (opcional)
        CustomTextField(
          labelText: 'Número de Páginas (opcional)',
          hintText: 'Ex: 176',
          prefixIcon: Icons.menu_book_outlined,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final pages = int.tryParse(value);
            controller.setPageCount(pages);
          },
        ),
        AppSpacing.verticalLG,

        // Descrição
        _buildDescriptionField(context),
      ],
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xs,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            'Sinopse',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: context.textColor),
          ),
        ),
        Container(
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
            maxLines: 5,
            onChanged: controller.setDescription,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: context.textColor),
            decoration: InputDecoration(
              hintText: 'Escreva uma breve descrição do livro...',
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
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.all(AppSpacing.md),
            ),
          ),
        ),
      ],
    );
  }
}
