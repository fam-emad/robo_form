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
      endDrawer: const RoboDrawer(
        logoAsset: 'assets/images/logo.png',
        wordmarkAsset: 'assets/images/title.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RoboNavBar(
              logoAsset: 'assets/images/logo.png',
              wordmarkAsset: 'assets/images/title.png',
              universityLogo: 'assets/images/asu_logo.jpg',
              unionLogo: 'assets/images/fcis_logo.jpg',
              calligraphyAsset: 'assets/images/wordmark.png',
            ),
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
