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
  _Committee('Mobile Dev', 'iOS, Android, Flutter', Icons.phone_android),
  _Committee('Software', 'Software / Programming', Icons.code),
  _Committee('Media & Design', 'Graphic, Video, Content', Icons.camera_alt_outlined),
  _Committee('PR', 'Public Relations / Outreach', Icons.campaign_outlined),
  _Committee('HR', 'Human Resources / Operations', Icons.groups_outlined),
  _Committee('Logistics', 'Events / Coordination', Icons.local_shipping_outlined),
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
                      color: AppColors.accent(i),
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
