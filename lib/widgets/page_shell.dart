import 'package:flutter/material.dart';
import 'footer_bar.dart';
import 'nav_bar.dart';

/// هيكل الصفحة المشترك: Scaffold + سكرول + NavBar + محتوى متوسّط بعرض أقصى + Footer.
class PageShell extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const PageShell({super.key, required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RoboNavBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: child,
              ),
            ),
            const FooterBar(),
          ],
        ),
      ),
    );
  }
}
