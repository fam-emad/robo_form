import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../widgets/widgets.dart';

/// رأس صفحة التسجيل: الشارة + العنوان + الوصف.
class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          StatusBadge(label: 'RECRUITMENT OPEN · 2026 / 27'),
          Spacer(),
          TagChip(label: 'Takes ~5 min', color: AppColors.amber),
        ]),
        Gap.v(16),
        AppText('Start Your Journey', 24, weight: FontWeight.w700),
        Gap.v(6),
        AppText.muted(
            'Fill in your details and choose the committee that fits your passion.',
            11),
        Gap.v(4),
        AppText.dim('* Required fields. Optional fields can be left blank.', 8.5),
      ],
    );
  }
}
