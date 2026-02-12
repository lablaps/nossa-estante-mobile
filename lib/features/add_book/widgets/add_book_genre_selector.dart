import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../add_book_controller.dart';

class AddBookGenreSelector extends StatelessWidget {
  final AddBookController controller;

  const AddBookGenreSelector({super.key, required this.controller});

  static const List<String> _availableGenres = [
    'Ficção',
    'Romance',
    'Fantasia',
    'Aventura',
    'Suspense',
    'Mistério',
    'Terror',
    'Ficção Científica',
    'Distopia',
    'História',
    'Biografia',
    'Autoajuda',
    'Filosofia',
    'Tecnologia',
    'Ciência',
    'Arte',
    'Culinária',
    'Negócios',
    'Economia',
    'Política',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gêneros', style: AppTextStyles.h6(context)),
        AppSpacing.verticalSM,
        Text(
          'Selecione um ou mais gêneros',
          style: AppTextStyles.bodySmall(
            context,
          ).copyWith(color: context.textMuted),
        ),
        AppSpacing.verticalMD,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _availableGenres.map((genre) {
            final isSelected = controller.selectedGenres.contains(genre);

            return GestureDetector(
              onTap: () => _toggleGenre(genre),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(
                          alpha: AppDimensions.opacityLow,
                        )
                      : context.inputBackground,
                  borderRadius: AppDimensions.borderRadiusSM,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : context.borderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  genre,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: isSelected ? AppColors.primary : context.textColor,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _toggleGenre(String genre) {
    final currentGenres = List<String>.from(controller.selectedGenres);

    if (currentGenres.contains(genre)) {
      currentGenres.remove(genre);
    } else {
      currentGenres.add(genre);
    }

    controller.setGenres(currentGenres);
  }
}
