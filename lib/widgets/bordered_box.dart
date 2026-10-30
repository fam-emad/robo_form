import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// الصندوق المدوّر اللي له بوردر — الأساس لكل: الكروت، حقول الإدخال، الشارات،
/// خيارات الاختيار، بانل الهيرو...
///
/// لو مرّرت [animationDuration] هيتحرك (AnimatedContainer) عند تغيير الألوان.
class BorderedBox extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  final Color borderColor;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Duration? animationDuration;

  const BorderedBox({
    super.key,
    this.child,
    this.color,
    this.gradient,
    this.borderColor = AppColors.border,
    this.radius = 8,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.constraints,
    this.animationDuration,
  });

  /// صندوق بلون شفاف من [tint] (خلفية + بوردر من نفس اللون).
  BorderedBox.tinted({
    super.key,
    required Color tint,
    double fillOpacity = 0.1,
    double borderOpacity = 0.5,
    this.child,
    this.radius = 8,
    this.padding,
    this.margin,
    this.width,
    this.height,
  })  : color = tint.withValues(alpha: fillOpacity),
        borderColor = tint.withValues(alpha: borderOpacity),
        gradient = null,
        constraints = null,
        animationDuration = null;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
    );

    if (animationDuration != null) {
      return AnimatedContainer(
        duration: animationDuration!,
        width: width,
        height: height,
        constraints: constraints,
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: child,
      );
    }
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}
