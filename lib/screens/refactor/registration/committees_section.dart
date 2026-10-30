import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';

class _Committee {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _Committee(this.name, this.subtitle, this.icon, this.color);
}

const _committees = [
  _Committee('Mobile Development', 'Flutter / App Dev',
      Icons.smartphone, Color(0xFF0EA5E9)),
  _Committee('AI', 'Machine Learning / Computer Vision / Deep Learning / NLP',
      Icons.psychology, Color(0xFF06B6D4)),
  _Committee('Embedded Systems', 'Hardware Architecture / Microcontrollers',
      Icons.memory, Color(0xFF10B981)),
  _Committee('IoT & Robotics', 'Adding Motion, Control and Connectivity',
      Icons.precision_manufacturing, Color(0xFFF97316)),
  _Committee('Mechanical Design', 'Designing Hardware Body',
      Icons.engineering, Color(0xFFF59E0B)),
  _Committee('Media & UI/UX', 'Graphic Design / Video Editing / Branding',
      Icons.design_services, Color(0xFFEC4899)),
  _Committee('PR', 'Presentation Skills / Communication Skills',
      Icons.campaign, Color(0xFF14B8A6)),
  _Committee('HR & PM', 'Human Resources / Project Management',
      Icons.groups, Color(0xFF9271F6)),
];

/// قسم "Preferred Committee(s)" مع RepaintBoundary لعزل إعادة الرسم.
class CommitteesSection extends StatelessWidget {
  final Set<String> selected;
  final bool showError;
  final ValueChanged<String> onToggle;

  const CommitteesSection({
    super.key,
    required this.selected,
    required this.showError,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      icon: Icons.groups_outlined,
      title: 'Preferred Committee(s) *',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AppText.dim('${selected.length} selected', 8.5),
          ),
          const Gap.v(8),
          // RepaintBoundary يعزل الـ grid عن بقية الصفحة عند كل اختيار
          RepaintBoundary(
            child: LayoutBuilder(builder: (context, c) {
              final w = c.maxWidth > 560 ? (c.maxWidth - 12) / 2 : c.maxWidth;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final committee in _committees)
                    // كل tile في RepaintBoundary مستقل
                    RepaintBoundary(
                      child: SizedBox(
                        width: w,
                        child: CommitteeTile(
                          title: committee.name,
                          subtitle: committee.subtitle,
                          icon: committee.icon,
                          color: committee.color,
                          selected: selected.contains(committee.name),
                          onTap: () => onToggle(committee.name),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
          if (showError)
            const FieldHelper('Select at least one committee', isError: true),
        ],
      ),
    );
  }
}
