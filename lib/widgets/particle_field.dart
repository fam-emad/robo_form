import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class _Particle {
  final double x, y, r, phase;
  final int speed, k;
  const _Particle(this.x, this.y, this.r, this.phase, this.speed, this.k);
}

/// جزيئات عايمة بتتوصل ببعض بخطوط خفيفة (شكل شبكة عصبية).
/// [progress] من 0 لـ 1 وبيتكرر، فاللوب بتبقى سلسة.
class ParticleField extends StatefulWidget {
  final double progress;
  final double opacity;
  final int count;
  final Color color;

  const ParticleField({
    super.key,
    required this.progress,
    this.opacity = 1,
    this.count = 55,
    this.color = AppColors.cyan,
  });

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> {
  late final List<_Particle> _ps;

  @override
  void initState() {
    super.initState();
    final rnd = math.Random(7);
    _ps = List.generate(
      widget.count,
      (_) => _Particle(
        rnd.nextDouble(),
        rnd.nextDouble(),
        0.8 + rnd.nextDouble() * 1.8,
        rnd.nextDouble() * math.pi * 2,
        1 + rnd.nextInt(2),
        1 + rnd.nextInt(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _ParticlePainter(
              _ps, widget.progress, widget.opacity, widget.color),
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> ps;
  final double t, opacity;
  final Color color;
  _ParticlePainter(this.ps, this.t, this.opacity, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final pts = <Offset>[];
    final dot = Paint();
    for (final p in ps) {
      final y = (p.y - t * p.speed) % 1.0;
      final x = p.x + math.sin(2 * math.pi * t * p.k + p.phase) * 0.015;
      final o = Offset(x * size.width, y * size.height);
      pts.add(o);
      final tw = 0.5 + 0.5 * math.sin(2 * math.pi * t * p.k * 2 + p.phase);
      dot.color = color.withOpacity((0.2 + 0.5 * tw) * opacity);
      canvas.drawCircle(o, p.r, dot);
    }
    final line = Paint()..strokeWidth = 0.6;
    const maxD = 110.0;
    for (var i = 0; i < pts.length; i++) {
      for (var j = i + 1; j < pts.length; j++) {
        final d = (pts[i] - pts[j]).distance;
        if (d < maxD) {
          line.color = color.withOpacity((1 - d / maxD) * 0.18 * opacity);
          canvas.drawLine(pts[i], pts[j], line);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) =>
      old.t != t || old.opacity != opacity;
}
