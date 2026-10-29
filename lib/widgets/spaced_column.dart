import 'package:flutter/material.dart';
import 'gap.dart';

/// Column بمسافة ثابتة بين العناصر (بدل SizedBox بين كل اتنين).
class SpacedColumn extends StatelessWidget {
  final double spacing;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  const SpacedColumn({
    super.key,
    required this.spacing,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) Gap.v(spacing),
          children[i],
        ],
      ],
    );
  }
}
