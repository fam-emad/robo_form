import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'icon_text.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({
    super.key,
    this.label = 'APPLICATION SUBMITTED',
    this.color = AppColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox.tinted(
      tint: color,
      radius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: IconText(
        icon: Icons.check_circle_outline,
        iconSize: 11,
        iconColor: color,
        gap: 6,
        label: AppText(label, 8,
            letterSpacing: 0.8, weight: FontWeight.w600, color: color),
      ),
    );
  }
}
