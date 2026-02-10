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
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: context.inputBackground,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: context.borderColor),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: context.textColor,
        tooltip: tooltip,
        iconSize: 24,
      ),
    );
  }
}
