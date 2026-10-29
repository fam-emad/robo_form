import 'package:flutter/material.dart';
import 'footer_bar.dart';
import 'nav_bar.dart';

/// هيكل الصفحة المشترك: Scaffold + سكرول + NavBar + محتوى متوسّط بعرض أقصى + Footer.
class PageShell extends StatelessWidget {
  final double maxWidth;
  final String activeTab;
  final Widget child;

  const PageShell({
    super.key,
    required this.maxWidth,
    this.activeTab = 'join',
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: RoboDrawer(
        logoAsset: 'assets/images/logo.png',
        wordmarkAsset: 'assets/images/title.png',
        activeTab: activeTab,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoboNavBar(
              logoAsset: 'assets/images/logo.png',
              wordmarkAsset: 'assets/images/title.png',
              universityLogo: 'assets/images/asu_logo.jpg',
              unionLogo: 'assets/images/fcis_logo.jpg',
              calligraphyAsset: 'assets/images/wordmark.png',
              activeTab: activeTab,
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
