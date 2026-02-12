import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../add_book_controller.dart';

class AddBookSettings extends StatelessWidget {
  final AddBookController controller;

  const AddBookSettings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção
        Row(
          children: [
            const Icon(Icons.settings_suggest, color: AppColors.primary),
            AppSpacing.horizontalSM,
            Text('Configurações de Troca', style: AppTextStyles.h6(context)),
          ],
        ),
        AppSpacing.verticalLG,

        // Condição do livro
        _buildConditionSelector(context),
        AppSpacing.verticalLG,

        // Idioma
        _buildLanguageSelector(context),
        AppSpacing.verticalLG,

        // Créditos necessários
        _buildCreditsSelector(context),
      ],
    );
  }

  Widget _buildConditionSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Condição do Livro', style: AppTextStyles.labelLarge(context)),
        AppSpacing.verticalSM,
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          children: BookCondition.values.map((condition) {
            final isSelected = controller.condition == condition;

            return GestureDetector(
              onTap: () => controller.setCondition(condition),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : context.inputBackground,
                  borderRadius: AppDimensions.borderRadiusSM,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : context.borderColor,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  condition.label,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: isSelected ? AppColors.textMain : context.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        AppSpacing.verticalXS,
        Text(
          _getConditionDescription(controller.condition),
          style: AppTextStyles.bodySmall(
            context,
          ).copyWith(color: context.textMuted),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    const languages = ['Português', 'Inglês', 'Espanhol', 'Francês', 'Outro'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Idioma', style: AppTextStyles.labelLarge(context)),
        AppSpacing.verticalSM,
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
          child: DropdownButtonFormField<String>(
            initialValue: controller.language,
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            items: languages.map((lang) {
              return DropdownMenuItem(value: lang, child: Text(lang));
            }).toList(),
            onChanged: controller.setLanguage,
            hint: Text(
              'Selecione o idioma',
              style: TextStyle(
                color: context.textMuted.withOpacity(AppDimensions.opacityHigh),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditsSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Créditos Necessários', style: AppTextStyles.labelLarge(context)),
        AppSpacing.verticalSM,
        Row(
          children: [
            IconButton(
              onPressed: controller.creditsRequired > 1
                  ? () => controller.setCreditsRequired(
                      controller.creditsRequired - 1,
                    )
                  : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: AppColors.primary,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.inputBackground,
                  borderRadius: AppDimensions.borderRadiusSM,
                  border: Border.all(color: context.borderColor),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.token, color: AppColors.primary, size: 20),
                    AppSpacing.horizontalXS,
                    Text(
                      '${controller.creditsRequired}',
                      style: AppTextStyles.h4(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: controller.creditsRequired < 10
                  ? () => controller.setCreditsRequired(
                      controller.creditsRequired + 1,
                    )
                  : null,
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.primary,
            ),
          ],
        ),
        AppSpacing.verticalXS,
        Center(
          child: Text(
            'Mínimo: 1 crédito • Máximo: 10 créditos',
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(color: context.textMuted),
          ),
        ),
      ],
    );
  }

  String _getConditionDescription(BookCondition condition) {
    switch (condition) {
      case BookCondition.new_:
        return 'Livro novo, sem uso ou marcas.';
      case BookCondition.likeNew:
        return 'Livro em excelente estado, com mínimos sinais de uso.';
      case BookCondition.good:
        return 'Livro em bom estado, com alguns sinais de uso.';
      case BookCondition.fair:
        return 'Livro usado, com marcas visíveis de desgaste.';
    }
  }
}
