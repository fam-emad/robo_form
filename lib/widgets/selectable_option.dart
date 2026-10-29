import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'bordered_box.dart';

/// خيار قابل للاختيار (محدد / غير محدد) — بيستخدمه الـ Radio وكارت اللجنة.
class SelectableOption extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double? height;

  const SelectableOption({
    super.key,
    required this.selected,
    required this.onTap,
    required this.child,
    this.color = AppColors.cyan,
    this.padding = EdgeInsets.zero,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: BorderedBox(
        height: height,
        padding: padding,
        color: selected ? color.withOpacity(0.1) : AppColors.cardAlt,
        borderColor: selected ? color : AppColors.border,
        child: child,
      ),
    );
  }
}
