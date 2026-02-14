import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class CategoryLanguageRow extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedLanguage;
  final void Function(String?) onCategoryChanged;
  final void Function(String?) onLanguageChanged;

  const CategoryLanguageRow({
    super.key,
    this.selectedCategory,
    this.selectedLanguage,
    required this.onCategoryChanged,
    required this.onLanguageChanged,
  });

  static const List<String> categories = [
    'Finanças',
    'Ficção',
    'Sci-Fi',
    'Biografia',
    'Autoajuda',
    'Romance',
    'Mistério',
    'História',
  ];

  static const List<String> languages = [
    'Inglês',
    'Português',
    'Espanhol',
    'Francês',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Category dropdown
        Expanded(
          child: _buildDropdown(
            context,
            label: 'Categoria',
            value: selectedCategory,
            items: categories,
            onChanged: onCategoryChanged,
          ),
        ),
        AppSpacing.horizontalMD,

        // Language dropdown
        Expanded(
          child: _buildDropdown(
            context,
            label: 'Idioma',
            value: selectedLanguage,
            items: languages,
            onChanged: onLanguageChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: AppTextStyles.labelMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.verticalSM,

        // Dropdown
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border.all(color: context.borderColor),
            borderRadius: AppDimensions.borderRadiusSM,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                'Selecione',
                style: AppTextStyles.bodyMedium(
                  context,
                ).copyWith(color: context.textMuted),
              ),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((String item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textColor,
                      ),
                    ),
                  );
                }).toList();
              },
              style: AppTextStyles.bodyMedium(context),
              dropdownColor: context.surfaceColor,
              icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
              menuMaxHeight: 300,
              borderRadius: AppDimensions.borderRadiusSM,
              items: items.map((String item) {
                final isSelected = item == value;
                return DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xs,
                      horizontal: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.transparent,
                      borderRadius: AppDimensions.borderRadiusSM,
                    ),
                    child: Row(
                      children: [
                        if (isSelected)
                          Padding(
                            padding: EdgeInsets.only(right: AppSpacing.sm),
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: AppDimensions.iconSM,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            item,
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : context.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
