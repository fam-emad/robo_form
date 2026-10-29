import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'icon_text.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const PrimaryButton({super.key, required this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [AppColors.red, AppColors.redDark],
            ),
          ),
          child: Center(
            child: IconText(
              icon: icon,
              iconSize: 16,
              iconAfter: true,
              label: AppText(label, 12, weight: FontWeight.w600),
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
