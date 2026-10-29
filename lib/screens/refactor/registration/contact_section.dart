import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/validators.dart';
import '../../../widgets/widgets.dart';
import 'field_keys.dart';

/// قسم "Contact Details".
class ContactSection extends StatelessWidget {
  final FieldKeys fieldKeys;
  final TextEditingController emailController;
  final VoidCallback onFieldChanged;

  const ContactSection({
    super.key,
    required this.fieldKeys,
    required this.emailController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      icon: Icons.call_outlined,
      title: 'Contact Details',
      child: SpacedColumn(spacing: 16, children: [
        AppTextField(
          key: fieldKeys['address'],
          label: 'Address',
          hint: 'City, Area',
          prefixIcon: Icons.location_on_outlined,
          rule: Validators.address,
          onChanged: (_) => onFieldChanged(),
        ),
        FieldRow(children: [
          AppTextField(
            key: fieldKeys['phone'],
            label: 'Mobile Phone',
            hint: '01XXXXXXXXX',
            helper: 'Egyptian mobile number, 11 digits',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 11,
            rule: Validators.egyptianPhone,
            onChanged: (_) => onFieldChanged(),
          ),
          AppTextField(
            key: fieldKeys['email'],
            controller: emailController,
            label: 'Email Address',
            hint: 'you@example.com',
            helper: 'We will send updates to this address',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            rule: Validators.email,
            onChanged: (_) => onFieldChanged(),
          ),
        ]),
      ]),
    );
  }
}
