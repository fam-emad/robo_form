import 'package:flutter/material.dart';
import 'gap.dart';

/// أيقونة + نص جنب بعض (الأيقونة اختيارية، ويمكن تتحط بعد النص).
class IconText extends StatelessWidget {
  final IconData? icon;
  final Widget label;
  final double iconSize;
  final Color? iconColor;
  final double gap;
  final bool iconAfter;

  const IconText({
    super.key,
    required this.label,
    this.icon,
    this.iconSize = 14,
    this.iconColor,
    this.gap = 8,
    this.iconAfter = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget =
        icon == null ? null : Icon(icon, size: iconSize, color: iconColor);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconWidget != null && !iconAfter) ...[iconWidget, Gap.h(gap)],
        label,
        if (iconWidget != null && iconAfter) ...[Gap.h(gap), iconWidget],
      ],
    );
  }
}
