import 'package:flutter/material.dart';
import '../../../core/validators.dart';
import '../../../widgets/widgets.dart';
import 'field_keys.dart';

const _departments = [
  'CS',
  'SC',
  'IS',
  'CSYS',
  'AI',
  'Robotics',
  'Cybersecurity',
  'Multi Media',
  'SWE',
];

/// قسم "Academic & Social".
class AcademicSection extends StatelessWidget {
  final FieldKeys fieldKeys;
  final String dept;
  final ValueChanged<String> onDeptChanged;
  final VoidCallback onFieldChanged;

  const AcademicSection({
    super.key,
    required this.fieldKeys,
    required this.dept,
    required this.onDeptChanged,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      icon: Icons.school_outlined,
      title: 'Academic & Social',
      child: SpacedColumn(spacing: 16, children: [
        FieldRow(children: [
          AppDropdownField<String>(
            label: 'Department / Major',
            value: dept,
            items: _departments,
            itemLabel: (s) => s,
            prefixIcon: Icons.school_outlined,
            onChanged: onDeptChanged,
          ),
          AppTextField(
            key: fieldKeys['discord'],
            label: 'Discord Username',
            hint: 'username',
            prefixIcon: Icons.alternate_email,
            rule: Validators.discord,
            onChanged: (_) => onFieldChanged(),
          ),
        ]),
        AppTextField(
          key: fieldKeys['linkedin'],
          label: 'LinkedIn Profile Link',
          hint: 'https://linkedin.com/in/username',
          helper: 'Optional · enter a valid LinkedIn URL',
          prefixIcon: Icons.link,
          isRequired: false,
          keyboardType: TextInputType.url,
          rule: Validators.linkedin,
          onChanged: (_) => onFieldChanged(),
        ),
      ]),
    );
  }
}
