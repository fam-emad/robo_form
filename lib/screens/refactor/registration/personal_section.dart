import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/validators.dart';
import '../../../widgets/widgets.dart';
import 'field_keys.dart';

const _levels = ['Level 0', 'Level 1', 'Level 2', 'Level 3', 'Level 4', 'Graduate'];

/// قسم "Personal Information".
class PersonalSection extends StatelessWidget {
  final FieldKeys fieldKeys;
  final TextEditingController enNameController;
  final String level;
  final bool isStudent;
  final VoidCallback onFieldChanged;
  final ValueChanged<String> onLevelChanged;
  final ValueChanged<bool> onStudentChanged;

  const PersonalSection({
    super.key,
    required this.fieldKeys,
    required this.enNameController,
    required this.level,
    required this.isStudent,
    required this.onFieldChanged,
    required this.onLevelChanged,
    required this.onStudentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      icon: Icons.person_outline,
      title: 'Personal Information',
      child: SpacedColumn(spacing: 16, children: [
        FieldRow(children: [
          AppTextField(
            key: fieldKeys['arName'],
            label: 'Full Name (Arabic)',
            hint: 'الاسم بالكامل',
            helper: 'Letters (Arabic) only',
            prefixIcon: Icons.person_outline,
            rtl: true,
            rule: Validators.arabicName,
            onChanged: (_) => onFieldChanged(),
          ),
          AppTextField(
            key: fieldKeys['enName'],
            controller: enNameController,
            label: 'Full Name (English)',
            hint: 'e.g. Ahmed Mohamed Ali',
            helper: 'English letters only — at least 2 names',
            prefixIcon: Icons.person_outline,
            rule: Validators.englishName,
            onChanged: (_) => onFieldChanged(),
          ),
        ]),
        FieldRow(children: [
          AppTextField(
            key: fieldKeys['nid'],
            label: 'National ID',
            hint: '14-digit national ID',
            helper: 'Must be exactly 14 digits',
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            rule: Validators.nationalId,
            onChanged: (_) => onFieldChanged(),
          ),
          AppTextField(
            key: fieldKeys['seat'],
            label: 'Seat Number',
            hint: 'e.g. 1021',
            helper: 'Leave blank if not applicable',
            prefixIcon: Icons.event_seat_outlined,
            isRequired: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            rule: Validators.digitsOnly,
            onChanged: (_) => onFieldChanged(),
          ),
        ]),
        FieldRow(children: [
          AppDropdownField<String>(
            label: 'Academic Level',
            value: level,
            items: _levels,
            itemLabel: (s) => s,
            prefixIcon: Icons.layers_outlined,
            helper: 'Level 0 · 1 · 2 · 3 · 4 · Graduate',
            onChanged: onLevelChanged,
          ),
          AppRadioGroup<bool>(
            label: 'Are you a student at our faculty?',
            options: const [true, false],
            optionLabel: (b) => b ? 'Yes' : 'No',
            value: isStudent,
            onChanged: onStudentChanged,
          ),
        ]),
      ]),
    );
  }
}
