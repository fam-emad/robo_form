import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';

/// الجزء اليمين في صفحة النجاح: الشارة + الشكر + بيانات الطلب + الأزرار.
class SuccessDetails extends StatelessWidget {
  final String applicantName;
  final String fullName;
  final List<String> committees;
  final String referenceId;

  const SuccessDetails({
    super.key,
    required this.applicantName,
    required this.fullName,
    required this.committees,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const StatusBadge(),
          const Gap.v(16),
          HeadingBlock(name: applicantName),
          const Gap.v(20),
          InfoCard(
              fullName: fullName,
              committees: committees,
              referenceId: referenceId),
          const Gap.v(16),
          PrimaryButton(
              label: 'Submit another application',
              icon: Icons.add,
              onTap: () => Navigator.of(context).maybePop()),
          const Gap.v(10),
          OutlineActionButton(
              label: 'Share with a Friend',
              icon: Icons.share_outlined,
              onTap: () {}),
        ],
      ),
    );
  }
}
