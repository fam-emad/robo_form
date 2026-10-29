import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../widgets/widgets.dart';
import 'academic_section.dart';
import 'agreement_section.dart';
import 'committees_section.dart';
import 'contact_section.dart';
import 'field_keys.dart';
import 'personal_section.dart';
import 'registration_header.dart';

/// كارت الفورم كامل (الأقسام + البانر + زرار الإرسال). مفيش فيه state:
/// كل البيانات والـ callbacks جاية من RegistrationScreen.
class RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FieldKeys fieldKeys;
  final TextEditingController enNameController;
  final TextEditingController emailController;
  final String level;
  final bool isStudent;
  final bool agreed;
  final bool attempted;
  final int errorCount;
  final Set<String> selectedCommittees;
  final VoidCallback onFieldChanged;
  final ValueChanged<String> onLevelChanged;
  final ValueChanged<bool> onStudentChanged;
  final ValueChanged<String> onCommitteeToggle;
  final ValueChanged<bool> onAgreeChanged;
  final VoidCallback onSubmit;

  const RegistrationForm({
    super.key,
    required this.formKey,
    required this.fieldKeys,
    required this.enNameController,
    required this.emailController,
    required this.level,
    required this.isStudent,
    required this.agreed,
    required this.attempted,
    required this.errorCount,
    required this.selectedCommittees,
    required this.onFieldChanged,
    required this.onLevelChanged,
    required this.onStudentChanged,
    required this.onCommitteeToggle,
    required this.onAgreeChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final hasErrors = attempted && errorCount > 0;
    return AppCard(
      padding: const EdgeInsets.all(28),
      radius: 20,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RegistrationHeader(),
            if (hasErrors) ...[
              const Gap.v(20),
              ErrorBanner(
                title:
                    'Please fix $errorCount highlighted field${errorCount == 1 ? '' : 's'} before submitting.',
                detail:
                    'Your other details and committee selections are preserved.',
              ),
            ],
            const Gap.v(28),
            PersonalSection(
              fieldKeys: fieldKeys,
              enNameController: enNameController,
              level: level,
              isStudent: isStudent,
              onFieldChanged: onFieldChanged,
              onLevelChanged: onLevelChanged,
              onStudentChanged: onStudentChanged,
            ),
            const Gap.v(28),
            ContactSection(
              fieldKeys: fieldKeys,
              emailController: emailController,
              onFieldChanged: onFieldChanged,
            ),
            const Gap.v(28),
            AcademicSection(
              fieldKeys: fieldKeys,
              onFieldChanged: onFieldChanged,
            ),
            const Gap.v(28),
            CommitteesSection(
              selected: selectedCommittees,
              showError: attempted && selectedCommittees.isEmpty,
              onToggle: onCommitteeToggle,
            ),
            const Gap.v(20),
            AgreementSection(
              agreed: agreed,
              showError: attempted && !agreed,
              onChanged: onAgreeChanged,
            ),
            const Gap.v(16),
            PrimaryButton(
                label: 'Apply Now',
                icon: Icons.arrow_forward,
                onTap: onSubmit),
            if (hasErrors)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: AppText('Fix all errors above to enable submission.', 9,
                      color: AppColors.red),
                ),
              ),
            const Gap.v(12),
            const HintLine(
                text:
                    'Your data is secure and used only for activity-related communication.'),
          ],
        ),
      ),
    );
  }
}
