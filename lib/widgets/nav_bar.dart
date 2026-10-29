import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../screens/about_screen.dart';
import 'app_text.dart';
import 'bordered_box.dart';
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
  final String title;
  final String subtitle;

  const UniversityBadge({
    super.key,
    this.logoAsset,
    this.title = 'Ain Shams University',
    this.subtitle = 'Faculty of Computer & Information Sciences',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageSlot(assetPath: logoAsset, width: 28, height: 28),
        const Gap.h(8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(title, 10, color: Colors.white),
              AppText.muted(
                subtitle,
                7.5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentUnionBadge extends StatelessWidget {
  final String? logoAsset;
  final String label;

  const StudentUnionBadge({
    super.key,
    this.logoAsset,
    this.label = 'FCIS Student Union',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageSlot(assetPath: logoAsset, width: 22, height: 22),
        const Gap.h(6),
        Flexible(
          child: AppText(
            label,
            9.5,
            weight: FontWeight.w600,
            color: AppColors.amber,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// القائمة الجانبية المنسدلة عند ضغط زر القائمة في شاشة الموبايل.
class RoboDrawer extends StatelessWidget {
  final String? logoAsset;
  final String? wordmarkAsset;
  final VoidCallback? onAboutTap;
  final VoidCallback? onJoinTap;

  const RoboDrawer({
    super.key,
    this.logoAsset,
    this.wordmarkAsset,
    this.onAboutTap,
    this.onJoinTap,
  });

  void _openAbout(BuildContext context) {
    Navigator.of(context).pop();
    if (onAboutTap != null) {
      onAboutTap!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    }
  }

  void _openJoin(BuildContext context) {
    Navigator.of(context).pop();
    if (onJoinTap != null) {
      onJoinTap!();
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.card,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BrandMark(logoAsset: logoAsset, wordmarkAsset: wordmarkAsset),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Gap.v(12),
              const Divider(color: AppColors.border, height: 1),
              const Gap.v(20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppColors.border),
                ),
                tileColor: AppColors.cardAlt,
                leading: const Icon(Icons.info_outline, color: AppColors.cyan, size: 20),
                title: const AppText('About RoboTech', 13, weight: FontWeight.w600),
                trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textDim),
                onTap: () => _openAbout(context),
              ),
              const Gap.v(12),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppColors.border),
                ),
                tileColor: AppColors.cardAlt,
                leading: const Icon(Icons.group_add_outlined, color: AppColors.cyan, size: 20),
                title: const AppText('Join the team', 13, weight: FontWeight.w600),
                trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textDim),
                onTap: () => _openJoin(context),
              ),
              const Spacer(),
              const Divider(color: AppColors.border, height: 1),
              const Gap.v(12),
              const Center(
                child: AppText.dim('RoboTech Recruitment 2026', 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoboNavBar extends StatelessWidget {
  final String? logoAsset;
  final String? wordmarkAsset;
  final String? universityLogo;
  final String? unionLogo;
  final String? calligraphyAsset;
  final VoidCallback? onAboutTap;
  final VoidCallback? onJoinTap;

  const RoboNavBar({
    super.key,
    this.logoAsset,
    this.wordmarkAsset,
    this.universityLogo,
    this.unionLogo,
    this.calligraphyAsset = 'assets/images/wordmark.png',
    this.onAboutTap,
    this.onJoinTap,
  });

  void _handleAbout(BuildContext context) {
    if (onAboutTap != null) {
      onAboutTap!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    }
  }

  void _handleJoin(BuildContext context) {
    if (onJoinTap != null) {
      onJoinTap!();
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.of(context).size.width < 800;

    if (compact) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  BrandMark(logoAsset: logoAsset, wordmarkAsset: wordmarkAsset),
                  const Spacer(),
                  if (calligraphyAsset != null) ...[
                    ImageSlot(
                      assetPath: calligraphyAsset,
                      width: 100,
                      height: 32,
                      fit: BoxFit.contain,
                      label: 'Calligraphy',
                    ),
                    const Gap.h(8),
                  ],
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: BorderedBox(
                      radius: 8,
                      padding: const EdgeInsets.all(6),
                      color: AppColors.cardAlt,
                      child: const Icon(Icons.menu, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(child: UniversityBadge(logoAsset: universityLogo)),
                  Container(
                    height: 20,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    color: AppColors.border,
                  ),
                  Expanded(child: StudentUnionBadge(logoAsset: unionLogo)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          BrandMark(logoAsset: logoAsset, wordmarkAsset: wordmarkAsset),
          const Spacer(),
          NavLink(
            label: 'About RoboTech',
            onTap: () => _handleAbout(context),
          ),
          NavLink(
            label: 'Join the team',
            active: true,
            onTap: () => _handleJoin(context),
          ),
          const Spacer(),
          UniversityBadge(logoAsset: universityLogo),
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
