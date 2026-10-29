import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/widgets.dart';

class CommitteeDetail {
  final String name;
  final String category;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> skills;

  const CommitteeDetail({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
    required this.description,
    required this.skills,
  });
}

const _allCommittees = [
  CommitteeDetail(
    name: 'Mobile Development',
    category: 'Software',
    icon: Icons.smartphone,
    color: Color(0xFF0EA5E9),
    description:
    'Build cross-platform apps from scratch using Dart and Flutter. Create interactive UIs, integrate APIs, and utilize mobile sensors to remotely control and monitor our robots.',
    skills: ['Dart & Flutter', 'Cross-Platform Dev', 'API Integration', 'UI Implementation', 'Hardware Control'],
  ),
  CommitteeDetail(
    name: 'AI',
    category: 'Software',
    icon: Icons.psychology,
    color: Color(0xFF06B6D4), // Purple
    description:
    'Journey from understanding data patterns to seeing the world. Master Data Analysis and ML, progressing to Deep Learning, CV, and NLP to give our machines true perception.',
    skills: ['Python', 'Data Analysis', 'Machine Learning', 'Computer Vision', 'NLP & Deep Learning'],
  ),
  CommitteeDetail(
    name: 'Embedded Systems',
    category: 'Hardware',
    icon: Icons.memory,
    color: Color(0xFF10B981), // Emerald Green
    description:
    'Bridge the gap between hardware and software. Design custom microcontrollers, write low-level code, and integrate sensors to create a seamless, zero-abstraction core system.',
    skills: ['Microcontrollers', 'C / C++', 'Sensors & Hardware', 'System Architecture', 'Low-Level Coding'],
  ),
  CommitteeDetail(
    name: 'IoT & Robotics',
    category: 'Hardware',
    icon: Icons.precision_manufacturing,
    color: Color(0xFFF97316),
    description:
    'Turn abstract code into a moving reality. Use sensors for environmental perception, control movement via motors, and connect machines using wired and wireless networks.',
    skills: ['Sensors & Motors', 'Wired/Wireless Networks', 'Hardware Assembly', 'Actuators', 'Robotics Logic'],
  ),
  CommitteeDetail(
    name: 'Mechanical Design',
    category: 'Hardware',
    icon: Icons.engineering,
    color: Color(0xFFF59E0B), // Amber / Gold
    description:
    'Transform ideas from 2D concepts into 3D reality. Apply physics and mechanics to design, assemble, and build a strong, balanced physical body that gives the robot its strength.',
    skills: ['Physics & Mechanics', '3D Modeling', 'Structural Assembly', 'CAD Design', 'Prototyping'],
  ),
  CommitteeDetail(
    name: 'Media & UI/UX',
    category: 'Creative',
    icon: Icons.design_services,
    color: Color(0xFFEC4899), // Rose / Pink
    description:
    'The aesthetic touch and imagination behind the tech. Engineer seamless user experiences (UI/UX), craft compelling visual media, and build an inspiring brand identity through storytelling.',
    skills: ['UI/UX Engineering', 'Visual Media & Video', 'Graphic Design', 'Branding', 'Storytelling'],
  ),
  CommitteeDetail(
    name: 'PR',
    category: 'Outreach',
    icon: Icons.campaign,
    color: Color(0xFF14B8A6), // Teal
    description:
    'The confident voice of the team. Develop elite communication and presentation skills, step out of your comfort zone, and effectively present our ideas to the world.',
    skills: ['Communication', 'Presentation Skills', 'Public Speaking', 'Confidence Building', 'Networking'],
  ),
  CommitteeDetail(
    name: 'HR & PM',
    category: 'Management',
    icon: Icons.groups,
    color: Color(0xFF9271F6), // Indigo / Violet
    description:
    'Build the foundation and culture where our team thrives. Discover raw talent, place people in their right spots, and transform individuals into one cohesive unit with a shared goal.',
    skills: ['Talent Discovery', 'Culture Building', 'Team Management', 'Operations', 'Strategic Planning'],
  ),
];

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: PageShell(
        maxWidth: 1000,
        activeTab: 'about',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button & Status Badge Header Row
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, size: 16, color: AppColors.cyan),
                        Gap.h(6),
                        AppText('Back to Registration', 11, color: AppColors.cyan, weight: FontWeight.w600),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const StatusBadge(label: 'OUR COMMITTEES · 2026 / 2027'),
              ],
            ),
            const Gap.v(14),
            const TwoToneTitle(
              first: 'About RoboTech',
              second: 'Committees & Teams.',
              size: 26,
            ),
            const Gap.v(6),
            const AppText.muted(
              'Discover our specialized technical, creative, and operational teams driving engineering excellence, innovation, and community growth.',
              12,
            ),
            const Gap.v(24),

            // Committee Cards Grid / List
            LayoutBuilder(builder: (context, c) {
              final wide = c.maxWidth > 650;
              final cardWidth = wide ? (c.maxWidth - 16) / 2 : c.maxWidth;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final item in _allCommittees)
                    SizedBox(
                      width: cardWidth,
                      child: _CommitteeCard(item: item),
                    ),
                ],
              );
            }),

            const Gap.v(32),
            // Call to Action Banner
            BorderedBox(
              radius: 16,
              padding: const EdgeInsets.all(24),
              color: AppColors.card,
              borderColor: AppColors.cyan.withValues(alpha: 0.3),
              child: LayoutBuilder(builder: (context, c) {
                final compact = c.maxWidth < 500;
                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText('Ready to start your journey?', 16, weight: FontWeight.w700),
                      const Gap.v(4),
                      const AppText.muted('Choose your preferred committee and apply for recruitment now.', 11),
                      const Gap.v(16),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: 'Apply Now',
                          icon: Icons.arrow_forward,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText('Ready to start your journey?', 16, weight: FontWeight.w700),
                          Gap.v(4),
                          AppText.muted('Choose your preferred committee and apply for recruitment now.', 11),
                        ],
                      ),
                    ),
                    const Gap.h(20),
                    SizedBox(
                      width: 150,
                      child: PrimaryButton(
                        label: 'Apply Now',
                        icon: Icons.arrow_forward,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommitteeCard extends StatelessWidget {
  final CommitteeDetail item;

  const _CommitteeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BorderedBox(
                radius: 10,
                padding: const EdgeInsets.all(10),
                color: item.color.withValues(alpha: 0.12),
                borderColor: item.color.withValues(alpha: 0.4),
                child: Icon(item.icon, size: 22, color: item.color),
              ),
              const Gap.h(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(item.name, 14, weight: FontWeight.w700),
                    const Gap.v(2),
                    BorderedBox(
                      radius: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      color: item.color.withValues(alpha: 0.08),
                      borderColor: item.color.withValues(alpha: 0.3),
                      child: AppText(item.category, 8.5, color: item.color, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap.v(14),
          AppText.muted(item.description, 11, height: 1.4),
          const Gap.v(16),
          const AppText.dim('KEY SKILLS & FOCUS', 8, letterSpacing: 1),
          const Gap.v(8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final skill in item.skills)
                BorderedBox(
                  radius: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: AppColors.cardAlt,
                  borderColor: AppColors.border,
                  child: AppText(skill, 9, color: AppColors.textMuted),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
