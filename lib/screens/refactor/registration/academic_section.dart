import 'package:flutter/material.dart';
import '../../../core/validators.dart';
import '../../../widgets/widgets.dart';
import 'field_keys.dart';

/// قسم "Academic & Social".
class AcademicSection extends StatelessWidget {
  final FieldKeys fieldKeys;
  final VoidCallback onFieldChanged;

  const AcademicSection({
    super.key,
    required this.fieldKeys,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      icon: Icons.school_outlined,
      title: 'Academic & Social',
      child: SpacedColumn(spacing: 16, children: [
        FieldRow(children: [
          AppTextField(
            key: fieldKeys['dept'],
            label: 'Department / Major',
            hint: 'e.g. Computer Science',
            prefixIcon: Icons.school_outlined,
            rule: (v) => Validators.minLength(v, 2),
            onChanged: (_) => onFieldChanged(),
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
