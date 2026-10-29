import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'gap.dart';

/// ---------- أجزاء مشتركة بتستخدمها كل حقول الفورم ----------

class FieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  final bool optional;
  const FieldLabel(this.text,
      {super.key, this.required = false, this.optional = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(text, 10,
            weight: FontWeight.w600, color: const Color(0xFFC3CCD8)),
        if (required) const AppText(' *', 10, color: AppColors.red),
        const Spacer(),
        if (optional) const AppText.dim('Optional', 8),
      ],
    );
  }
}

class FieldHelper extends StatelessWidget {
  final String text;
  final bool isError;
  const FieldHelper(this.text, {super.key, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: AppText(text, 8.5,
          color: isError ? AppColors.red : AppColors.textDim),
    );
  }
}

/// الصندوق اللي حوالين أي حقل (نص / قايمة منسدلة) بحالاته: عادي / فوكس / خطأ.
class FieldBox extends StatelessWidget {
  final Widget child;
  final bool hasError;
  final bool focused;
  const FieldBox(
      {super.key,
      required this.child,
      this.hasError = false,
      this.focused = false});

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      animationDuration: const Duration(milliseconds: 150),
      constraints: const BoxConstraints(minHeight: 46),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: hasError ? AppColors.red.withOpacity(0.07) : AppColors.cardAlt,
      borderColor: hasError
          ? AppColors.red
          : focused
              ? AppColors.cyan
              : AppColors.border,
      child: child,
    );
  }
}

/// الشكل العام لأي حقل: لابل فوق، الحقل نفسه، وتحته رسالة الخطأ أو الـ helper.
/// رسالة الخطأ بتحل محل الـ helper.
class LabeledField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? helper;
  final String? error;
  final Widget child;

  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.isRequired = true,
    this.helper,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label, required: isRequired, optional: !isRequired),
        const Gap.v(6),
        child,
        if (error != null)
          FieldHelper(error!, isError: true)
        else if (helper != null)
          FieldHelper(helper!),
      ],
    );
  }
}
