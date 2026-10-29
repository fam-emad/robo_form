import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'gap.dart';

/// مكان للصورة / اللوجو. لو مدخلتش [assetPath] بيظهر مربع فاضي.
/// مثال: ImageSlot(assetPath: 'assets/images/logo.png', height: 40)
class ImageSlot extends StatelessWidget {
  final String? assetPath;
  final double? width;
  final double? height;
  final String label;
  final BoxFit fit;
  final double radius;

  const ImageSlot({
    super.key,
    this.assetPath,
    this.width,
    this.height,
    this.label = 'Image',
    this.fit = BoxFit.contain,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return SizedBox(
        width: width,
        height: height,
        child: Image.asset(assetPath!, fit: fit),
      );
    }
    final small = (height ?? 100) < 48;
    return BorderedBox(
      width: width,
      height: height,
      radius: radius,
      color: AppColors.cardAlt,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined,
                size: small ? 16 : 28, color: AppColors.textDim),
            if (!small) ...[
              const Gap.v(6),
              AppText.dim(label, 10),
            ],
          ],
        ),
      ),
    );
  }
}
