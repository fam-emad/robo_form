import 'package:flutter/material.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'gap.dart';
import 'image_slot.dart';
import 'two_tone_title.dart';

/// البانل الشمال: صورة الروبوت + اللوجو + الشعار + الخط العربي.
/// كل الصور مكانها فاضي، مرر المسارات لما تجهزها.
class HeroPanel extends StatelessWidget {
  final String? robotImage;
  final String? logoWordmarkImage;

  const HeroPanel({
    super.key,
    this.robotImage = "assets/images/logo.png",
    this.logoWordmarkImage = "assets/images/wordmark.png",
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      padding: const EdgeInsets.all(20),
      radius: 16,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0E1824), Color(0xFF080D14)],
      ),
      child: Column(
        children: [
          const AppText.muted('THE NEXT GENERATION', 7, letterSpacing: 1.5),
          const Gap.v(12),
          Expanded(
            child: ImageSlot(
              assetPath: robotImage,
              width: double.infinity,
              label: 'Robot head image',
              fit: BoxFit.cover,
            ),
          ),
          const Gap.v(14),
          ImageSlot(
              assetPath: logoWordmarkImage,
              width: double.infinity,
              label: 'Arabic calligraphy'),
          const Gap.v(10),
          const AppText.dim('BUILT BY STUDENTS, FOR Students', 6,
              letterSpacing: 1.2),
        ],
      ),
    );
  }
}
