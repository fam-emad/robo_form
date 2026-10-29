import 'package:flutter/widgets.dart';

/// مسافة فاضية. `Gap.v(16)` رأسي (جوه Column)، `Gap.h(8)` أفقي (جوه Row).
class Gap extends StatelessWidget {
  final double? _width;
  final double? _height;

  const Gap.v(double size, {super.key})
      : _width = null,
        _height = size;

  const Gap.h(double size, {super.key})
      : _width = size,
        _height = null;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: _width, height: _height);
}
