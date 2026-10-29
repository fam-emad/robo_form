import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// نص بحجم محدد، بدل تكرار `Text(..., style: TextStyle(fontSize: ..., color: ...))`.
///
///  • `AppText('..', 12)`        → اللون الافتراضي (أبيض)
///  • `AppText.muted('..', 9)`   → رمادي فاتح
///  • `AppText.dim('..', 8)`     → رمادي غامق
class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final double? letterSpacing;

  const AppText(
    this.text,
    this.size, {
    super.key,
    this.color,
    this.weight,
    this.height,
    this.letterSpacing,
  });

  const AppText.muted(
    this.text,
    this.size, {
    super.key,
    this.weight,
    this.height,
    this.letterSpacing,
  }) : color = AppColors.textMuted;

  const AppText.dim(
    this.text,
    this.size, {
    super.key,
    this.weight,
    this.height,
    this.letterSpacing,
  }) : color = AppColors.textDim;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
