import 'package:flutter/material.dart';
import '../theme/theme_extensions.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? context.inputBackground : context.surfaceColor,
        shape: BoxShape.circle,
        border: Border.all(color: context.borderColor),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: context.textColor,
        tooltip: tooltip,
        iconSize: 28,
      ),
    );
  }
}
