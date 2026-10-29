import 'package:flutter/material.dart';
import 'app_text.dart';
import 'gap.dart';
import 'two_tone_title.dart';

class HeadingBlock extends StatelessWidget {
  final String name;
  const HeadingBlock({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoToneTitle(
          first: 'Thank you, $name.',
          second: 'Welcome to RoboTech.',
          size: 30,
          height: 1.15,
          alignment: CrossAxisAlignment.start,
        ),
        const Gap.v(14),
        const AppText.muted(
          'Your application has been received. Our team will review it and reach out soon. '
          'Check your email and Discord for updates.',
          12,
          height: 1.5,
        ),
      ],
    );
  }
}
