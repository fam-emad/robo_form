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
    category: 'Technical',
    icon: Icons.smartphone,
    color: AppColors.cyan,
    description:
        'Build high-performance, beautiful cross-platform applications using Flutter and Dart. Learn modern app architecture, state management, REST APIs, and UI/UX implementation.',
    skills: ['Flutter', 'Dart', 'State Management', 'REST API', 'Git'],
  ),
  CommitteeDetail(
    name: 'AI & Data Science',
    category: 'Technical',
    icon: Icons.psychology,
    color: AppColors.cyan,
    description:
        'Explore Machine Learning, Computer Vision, Deep Learning, and NLP. Train intelligent models for real-world robotics and automation tasks.',
    skills: ['Python', 'Machine Learning', 'Computer Vision', 'PyTorch', 'NLP'],
  ),
  CommitteeDetail(
    name: 'Embedded Systems',
    category: 'Technical',
    icon: Icons.memory,
    color: AppColors.cyan,
    description:
        'The heart of hardware intelligence. Design firmware for microcontrollers, write C/C++, interface with sensors, and master real-time operating systems.',
    skills: ['C / C++', 'Microcontrollers', 'AVR / ARM / ESP32', 'RTOS', 'Protocols'],
  ),
  CommitteeDetail(
    name: 'IoT & Robotics',
    category: 'Technical',
    icon: Icons.precision_manufacturing,
    color: AppColors.cyan,
    description:
        'Bring physical machines to life. Focus on kinematics, control systems, ROS (Robot Operating System), wireless connectivity, and autonomous robotic navigation.',
    skills: ['ROS', 'Kinematics', 'Control Systems', 'MQTT', 'Autonomous Systems'],
  ),
  CommitteeDetail(
    name: 'Mechanical Design',
    category: 'Technical',
    icon: Icons.engineering,
    color: AppColors.cyan,
    description:
        'Engineer the physical body and structural integrity of robots. Master 3D CAD modeling, SolidWorks, stress analysis, 3D printing, and mechanical fabrication.',
    skills: ['SolidWorks', '3D CAD', '3D Printing', 'Chassis Design', 'Fabrication'],
  ),
  CommitteeDetail(
    name: 'Media & UI/UX',
    category: 'Creative',
    icon: Icons.design_services,
    color: AppColors.amber,
    description:
        'Shape RoboTech\'s visual identity. Create compelling UI/UX mockups, graphic designs, promotional videos, photography, and brand identity materials.',
    skills: ['Figma UI/UX', 'Graphic Design', 'Video Editing', 'Branding', 'Motion Graphics'],
  ),
  CommitteeDetail(
    name: 'PR & Marketing',
    category: 'Operations',
    icon: Icons.campaign,
    color: AppColors.green,
    description:
        'The voice and face of RoboTech. Build relationships with sponsors, manage public relations, organize major tech events, and hone elite presentation skills.',
    skills: ['Public Speaking', 'Sponsorship', 'Communication', 'Event Hosting', 'PR Strategy'],
  ),
  CommitteeDetail(
    name: 'HR & PM',
    category: 'Management',
    icon: Icons.groups,
    color: Color(0xFFA855F7), // Soft Royal Purple for Leadership & Management
    description:
        'Drive team performance and project delivery. Recruit top talent, foster team culture, monitor project milestones, and ensure operational excellence.',
    skills: ['Project Management', 'Agile / Scrum', 'Talent Acquisition', 'Leadership', 'Operations'],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button & Header
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                const StatusBadge(label: 'OUR COMMITTEES · 2026 / 27'),
              ],
            ),
            const Gap.v(20),
            const TwoToneTitle(
              first: 'About RoboTech',
              second: 'Committees & Teams.',
              size: 26,
            ),
            const Gap.v(8),
            const AppText.muted(
              'Discover our specialized technical, creative, and operational teams driving engineering excellence, innovation, and community growth.',
              12,
            ),
            const Gap.v(28),

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

            const Gap.v(36),
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
