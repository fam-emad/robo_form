import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'bordered_box.dart';

/// الكارت الأساسي (الحاوية الكبيرة).
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      padding: padding,
      radius: radius,
      color: color ?? AppColors.card,
      child: child,
    );
  }
}
