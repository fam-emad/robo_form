import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'gap.dart';
import 'image_slot.dart';

class NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const NavLink({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              label,
              12,
              color: active ? Colors.white : AppColors.textMuted,
            ),
            const Gap.v(4),
            Container(
              height: 2,
              width: 28,
              color: active ? AppColors.red : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

/// لوجو RoboTech + الكلمة اللي جنبه (مكان صور).
class BrandMark extends StatelessWidget {
  final String? logoAsset;
  final String? wordmarkAsset;

  const BrandMark({super.key, this.logoAsset, this.wordmarkAsset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageSlot(assetPath: logoAsset, width: 36, height: 36, label: 'Logo'),
        const Gap.h(10),
        ImageSlot(
            assetPath: wordmarkAsset,
            width: 90,
            height: 28,
            label: 'RoboTech wordmark'),
      ],
    );
  }
}

class UniversityBadge extends StatelessWidget {
  final String? logoAsset;
  const UniversityBadge({super.key, this.logoAsset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageSlot(assetPath: logoAsset, width: 28, height: 28),
        const Gap.h(8),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText('Ain Shams University', 10, color: Colors.white),
            AppText.muted('Faculty of Engineering · Mechatronics Sciences', 7),
          ],
        ),
      ],
    );
  }
}

class StudentUnionBadge extends StatelessWidget {
  final String? logoAsset;
  const StudentUnionBadge({super.key, this.logoAsset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageSlot(assetPath: logoAsset, width: 20, height: 20),
        const Gap.h(6),
        const AppText('FOR Student Union', 8, color: AppColors.amber),
      ],
    );
  }
}

class RoboNavBar extends StatelessWidget {
  final String? logoAsset;
  final String? wordmarkAsset;
  final String? universityLogo;
  final String? unionLogo;

  const RoboNavBar({
    super.key,
    this.logoAsset,
    this.wordmarkAsset,
    this.universityLogo,
    this.unionLogo,
  });

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 40, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          BrandMark(logoAsset: logoAsset, wordmarkAsset: wordmarkAsset),
          const Spacer(),
          if (!compact) ...const [
            NavLink(label: 'About RoboTech'),
            NavLink(label: 'Join the team', active: true),
          ],
          const Spacer(),
          if (!compact) UniversityBadge(logoAsset: universityLogo),
          if (!compact)
            Container(
              height: 24,
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.border,
            ),
          StudentUnionBadge(logoAsset: unionLogo),
        ],
      ),
    );
  }
}
