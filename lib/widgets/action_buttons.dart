import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'icon_text.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? color;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.gradient,
    this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ??
        (color == null
            ? const LinearGradient(
                colors: [Color(0xFF35D0E6), Color(0xFF00B4D8)],
              )
            : null);

    final isCyanDefault = effectiveGradient != null && color == null;
    final finalTextColor = isCyanDefault && textColor == Colors.white
        ? const Color(0xFF070B12)
        : textColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 46,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            gradient: effectiveGradient,
            boxShadow: [
              BoxShadow(
                color: (color ?? const Color(0xFF35D0E6)).withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: IconText(
              icon: icon,
              iconSize: 16,
              iconColor: finalTextColor,
              iconAfter: true,
              label: AppText(label, 12, weight: FontWeight.w700, color: finalTextColor),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const OutlineActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: BorderedBox(
        height: 42,
        radius: 10,
        child: Center(
          child: IconText(
            icon: icon,
            iconSize: 14,
            iconColor: AppColors.textMuted,
            label: AppText.muted(label, 11),
          ),
        ),
      ),
    );
  }
}
