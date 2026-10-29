import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'gap.dart';

class HintLine extends StatelessWidget {
  final String text;
  const HintLine(
      {super.key,
      this.text = 'Keep an eye on your inbox. Your journey is just getting started.'});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
              color: AppColors.green, shape: BoxShape.circle),
        ),
        const Gap.h(8),
        Flexible(child: AppText.muted(text, 9)),
      ],
    );
  }
}
