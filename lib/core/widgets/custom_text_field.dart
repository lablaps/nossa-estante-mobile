import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/theme_extensions.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              labelText!,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: context.textColor),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            enabled: enabled,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: context.textColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: context.textMuted.withOpacity(0.6)),
              filled: true,
              fillColor: context.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: context.textMuted)
                  : null,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: prefixIcon != null ? 12 : 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
