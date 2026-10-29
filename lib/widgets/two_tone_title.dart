import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';

/// عنوان من سطرين: الأول أبيض والتاني سماوي.
class TwoToneTitle extends StatelessWidget {
  final String first;
  final String second;
  final double size;
  final double? height;
  final CrossAxisAlignment alignment;

  const TwoToneTitle({
    super.key,
    required this.first,
    required this.second,
    required this.size,
    this.height,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(first, size, weight: FontWeight.w700, height: height),
        AppText(second, size,
            weight: FontWeight.w700, height: height, color: AppColors.cyan),
      ],
    );
  }
}
