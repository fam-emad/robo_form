import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'gap.dart';
import 'icon_text.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  Future<void> onContact() async {
    final Uri facebookUri = Uri.parse("https://www.facebook.com/RoboTech.FCIS");

    try {
      await launchUrl(
        facebookUri,
        mode: LaunchMode.platformDefault,
      );
    } catch (e) {
      debugPrint("Could not launch Facebook: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 10,
        spacing: 20,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.dim('ROBOTECH  |  2026  |  COMMUNITY', 8),
              Gap.v(4),
              AppText.dim(
                  '© 2026 RoboTech. Ain Shams University, Building Engineering Sci.',
                  8),
            ],
          ),
          InkWell(
            onTap: onContact,
            child: const IconText(
              icon: Icons.chat_bubble_outline,
              iconSize: 12,
              iconColor: AppColors.cyan,
              gap: 6,
              label: AppText.muted('Have a question? Contact RoboTech team', 9),
            ),
          ),
        ],
      ),
    );
  }
}
