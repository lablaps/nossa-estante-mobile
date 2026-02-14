import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class ValidatedTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String value;
  final bool isValid;
  final void Function(String) onChanged;
  final TextInputType? keyboardType;
  final int maxLines;

  const ValidatedTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.isValid,
    required this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Text(
            label,
            style: AppTextStyles.labelMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),

        // Input field
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: AppTextStyles.bodyMedium(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMedium(
              context,
            ).copyWith(color: context.textMuted),
            filled: true,
            fillColor: context.surfaceColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: maxLines > 1 ? AppSpacing.md : AppSpacing.sm,
            ),
            suffixIcon: value.trim().isNotEmpty && isValid
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: AppDimensions.iconMD,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(color: context.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(color: context.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
