import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'refactor/success/success_card.dart';

class SuccessScreen extends StatelessWidget {
  final String applicantName;
  final String fullName;
  final List<String> committees;
  final String referenceId;

  const SuccessScreen({
    super.key,
    required this.applicantName,
    required this.fullName,
    required this.committees,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    return PageShell(
      maxWidth: 1000,
      child: Column(
        children: [
          SuccessCard(
            applicantName: applicantName,
            fullName: fullName,
            committees: committees,
            referenceId: referenceId,
          ),
          const Gap.v(24),
          const HintLine(),
        ],
      ),
    );
  }
}
