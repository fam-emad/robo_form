import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../widgets/widgets.dart';

class _Committee {
  final String name;
  final String subtitle;
  final IconData icon;
  const _Committee(this.name, this.subtitle, this.icon);
}

const _committees = [
  _Committee('Mobile Development', 'Flutter / App Dev', Icons.smartphone),
  _Committee('AI', 'Machine Learning / Computer Vision / Deep Learning / NLP', Icons.psychology),
  _Committee('Embedded Systems', 'Microcontrollers', Icons.memory),
  _Committee('IoT & Robotics', 'Adding Motion, Control and Connectivity', Icons.precision_manufacturing),
  _Committee('Mechanical Design', 'Designing Hardware Body', Icons.engineering),

  _Committee('Media & UI/UX', 'Graphic Design / Video Editing / Branding', Icons.design_services),
  _Committee('PR', 'Presentation Skills / Communication Skills', Icons.campaign), // أو Icons.public
  _Committee('HR & PM', 'Human Resources / Project Management', Icons.groups),
  ];

/// قسم "Preferred Committee(s)".
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
          LayoutBuilder(builder: (context, c) {
            final w = c.maxWidth > 560 ? (c.maxWidth - 12) / 2 : c.maxWidth;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (var i = 0; i < _committees.length; i++)
                  SizedBox(
                    width: w,
                    child: CommitteeTile(
                      title: _committees[i].name,
                      subtitle: _committees[i].subtitle,
                      icon: _committees[i].icon,
                      color: AppColors.cyan,
                      selected: selected.contains(_committees[i].name),
                      onTap: () => onToggle(_committees[i].name),
                    ),
                  ),
              ],
            );
          }),
          if (showError)
            const FieldHelper('Select at least one committee', isError: true),
        ],
      ),
    );
  }
}
