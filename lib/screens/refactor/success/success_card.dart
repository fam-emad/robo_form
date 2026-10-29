import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';
import 'success_details.dart';

/// الكارت الكبير: الهيرو + التفاصيل (جنب بعض على العريض، فوق بعض على الموبايل).
class SuccessCard extends StatelessWidget {
  final String applicantName;
  final String fullName;
  final List<String> committees;
  final String referenceId;

  const SuccessCard({
    super.key,
    required this.applicantName,
    required this.fullName,
    required this.committees,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    final details = SuccessDetails(
      applicantName: applicantName,
      fullName: fullName,
      committees: committees,
      referenceId: referenceId,
    );
    return AppCard(
      padding: const EdgeInsets.all(20),
      radius: 24,
      child: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth > 720;
        const hero = SizedBox(height: 520, child: HeroPanel());
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 340, child: hero),
              const Gap.h(24),
              Expanded(child: details),
            ],
          );
        }
        return Column(children: [
          hero,
          const Gap.v(20),
          details,
        ]);
      }),
    );
  }
}
