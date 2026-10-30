import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/action_buttons.dart';
import '../widgets/image_slot.dart';
import '../widgets/particle_field.dart';
import '../widgets/status_badge.dart';
import 'registration_screen.dart';

/// صفحة البداية: صورة الروبوت في الخلفية بحركة، اللوجو في النص، وزرار الدخول للفورم.
class SplashScreen extends StatefulWidget {
  final String robotAsset;
  final String logoAsset;

  const SplashScreen({
    super.key,
    this.robotAsset = 'assets/images/Robotics vision.png',
    this.logoAsset = 'assets/images/title.png',
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _intro; // مرة واحدة 0 → 1
  late final AnimationController _loop; // بيتكرر طول الوقت
  Offset _parallax = Offset.zero;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3600))
      ..forward();
    _loop = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
  }

  @override
  void dispose() {
    _intro.dispose();
    _loop.dispose();
    super.dispose();
  }

  /// قيمة مرحلة من الانيميشن بين a و b (من 0 لـ 1).
  double _t(double a, double b, [Curve curve = Curves.easeOutCubic]) {
    final v = ((_intro.value - a) / (b - a)).clamp(0.0, 1.0).toDouble();
    return curve.transform(v);
  }

  void _skipIntro() {
    if (_intro.isAnimating) {
      _intro.animateTo(1, duration: const Duration(milliseconds: 350));
    }
  }

  void _enter() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (_, __, ___) => const RegistrationScreen(),
      transitionsBuilder: (_, anim, __, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween(begin: 1.05, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: MouseRegion(
        onHover: (e) {
          final s = MediaQuery.sizeOf(context);
          setState(() => _parallax = Offset(
                (e.position.dx / s.width - 0.5) * 2,
                (e.position.dy / s.height - 0.5) * 2,
              ));
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _skipIntro,
          child: AnimatedBuilder(
            animation: Listenable.merge([_intro, _loop]),
            builder: (_, __) => _stage(MediaQuery.sizeOf(context)),
          ),
        ),
      ),
    );
  }

  Widget _stage(Size size) {
    final loop = _loop.value;
    final pulse = 0.5 + 0.5 * math.sin(2 * math.pi * loop);
    final bgIn = _t(0, 0.35);
    final zoom = (1.3 - 0.2 * _t(0, 1)) * (1 + 0.02 * math.sin(2 * math.pi * loop));

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1) صورة الروبوت: زوم بطيء + باراللاكس مع الماوس + حركة تنفس
        Transform.scale(
          scale: zoom,
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(end: _parallax),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            builder: (_, o, child) => Transform.translate(
                offset: Offset(-o.dx * 14, -o.dy * 10), child: child),
            child: Opacity(
              opacity: 0.6 * bgIn,
              child: ImageSlot(
                assetPath: widget.robotAsset,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                label: 'Robot image',
              ),
            ),
          ),
        ),

        // 2) توهج سماوي بينبض في النص
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.65,
                colors: [
                  AppColors.cyan.withOpacity((0.08 + 0.10 * pulse) * bgIn),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // 3) فينييت عشان الحواف تغمق والكلام يبان
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.05,
                colors: [
                  Colors.transparent,
                  AppColors.bg.withOpacity(0.55),
                  AppColors.bg.withOpacity(0.96),
                ],
                stops: const [0.25, 0.7, 1],
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.bg.withOpacity(0.5),
                  Colors.transparent,
                  AppColors.bg.withOpacity(0.85),
                ],
                stops: const [0, 0.45, 1],
              ),
            ),
          ),
        ),

        // 4) جزيئات
        ParticleField(progress: loop, opacity: bgIn),

        // 5) خط سكانر بينزل لتحت
        Positioned(
          top: loop * (size.height + 120) - 120,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.55 * bgIn,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.cyan.withOpacity(0.10),
                      AppColors.cyan.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // 6) أقواس HUD في الأركان
        _bracket(Alignment.topLeft, _t(0.6, 0.9)),
        _bracket(Alignment.topRight, _t(0.6, 0.9)),
        _bracket(Alignment.bottomLeft, _t(0.6, 0.9)),
        _bracket(Alignment.bottomRight, _t(0.6, 0.9)),

        // 7) المحتوى: لوجو + شعار + زرار
        SafeArea(child: Center(child: _content(size, pulse))),

        // 8) سطر صغير تحت
        Positioned(
          bottom: 22,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Opacity(
              opacity: _t(0.9, 1),
              child: const Center(
                child: Text('BUILT BY STUDENTS, FOR TOMORROW',
                    style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 1.8,
                        color: AppColors.textDim)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _content(Size size, double pulse) {
    final contentW = math.min(size.width - 40, 560.0);
    final logoW = math.min(contentW * 0.8, 320.0);
    final big = size.width > 600;

    // اللوجو: بلور بيتشال + سكيل + فيد
    final logoOpacity = _t(0.2, 0.5);
    final logoScale = 0.8 + 0.2 * _t(0.2, 0.6, Curves.easeOutBack);
    final blur = 14 * (1 - _t(0.2, 0.6));
    Widget logo = Opacity(
      opacity: logoOpacity,
      child: ImageSlot(
          assetPath: widget.logoAsset, width: logoW, label: 'RoboTech logo'),
    );
    if (blur > 0.1) {
      logo = ImageFiltered(
        imageFilter: ImageFilter.blur(
            sigmaX: blur, sigmaY: blur, tileMode: TileMode.decal),
        child: logo,
      );
    }

    final tagT = _t(0.55, 0.8);
    final ctaT = _t(0.78, 1);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: contentW,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: _t(0.12, 0.4),
              child: Text(
                'THE NEXT GENERATION',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2 + 8 * (1 - _t(0.12, 0.5)),
                  color: AppColors.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Transform.scale(
              scale: logoScale,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan
                          .withOpacity((0.10 + 0.10 * pulse) * logoOpacity),
                      blurRadius: 70,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: logo,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 2,
              width: logoW * 0.55 * _t(0.5, 0.75),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.red, AppColors.cyan]),
              ),
            ),
            const SizedBox(height: 28),
            Opacity(
              opacity: tagT,
              child: Transform.translate(
                offset: Offset(0, 18 * (1 - tagT)),
                child: Column(children: [
                  Text('Human curiosity.',
                      style: TextStyle(
                          fontSize: big ? 30 : 22,
                          fontWeight: FontWeight.w700)),
                  Text('Limitless possibility.',
                      style: TextStyle(
                          fontSize: big ? 30 : 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cyan)),
                ]),
              ),
            ),
            const SizedBox(height: 40),
            Opacity(
              opacity: ctaT,
              child: Transform.translate(
                offset: Offset(0, 24 * (1 - ctaT)),
                child: IgnorePointer(
                  ignoring: ctaT < 0.5,
                  child: Column(children: [
                    const StatusBadge(label: 'RECRUITMENT OPEN · 2026 / 27'),
                    const SizedBox(height: 18),
                    Container(
                      width: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.red
                                .withOpacity(0.25 + 0.30 * pulse),
                            blurRadius: 18 + 18 * pulse,
                          ),
                        ],
                      ),
                      child: PrimaryButton(
                        label: 'Start Your Journey',
                        icon: Icons.arrow_forward,
                        onTap: _enter,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bracket(Alignment a, double o) {
    final top = a.y < 0;
    final left = a.x < 0;
    const s = BorderSide(color: AppColors.cyan, width: 1.5);
    return Align(
      alignment: a,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Opacity(
          opacity: o * 0.6,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border(
                top: top ? s : BorderSide.none,
                bottom: top ? BorderSide.none : s,
                left: left ? s : BorderSide.none,
                right: left ? BorderSide.none : s,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
