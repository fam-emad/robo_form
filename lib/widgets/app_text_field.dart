import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/app_colors.dart';
import 'field_parts.dart';
import 'gap.dart';

/// ---------- حقل النص الكاستم ----------
///
/// بيشتغل جوه Form عادي (validate / reset / save) وفيه:
///  • لابل + نجمة required أو كلمة Optional
///  • أيقونة أول الحقل، وأيقونة حالة آخره (خطأ أحمر / صح سماوي)
///  • hint و helper text، ورسالة الخطأ بتحل محل الـ helper
///  • الفاليديشن بيظهر لما تخرج من الحقل أو تعمل submit،
///    وبعدها بيتحدّث مع كل حرف تكتبه
///  • حقل Optional: لو فاضي مفيش خطأ، ولو مكتوب فيه بيتفحص بالـ rule
///  • دعم RTL للعربي، inputFormatters، keyboardType، maxLength
///
/// (أجزاء الحقل المشتركة — اللابل، الصندوق، الـ helper — في field_parts.dart)
class AppTextField extends FormField<String> {
  final String label;
  final String? hint;
  final String? helper;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool rtl;
  final bool isRequired;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.helper,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.rtl = false,
    this.isRequired = true,
    this.maxLength,
    this.onChanged,
    String? Function(String value)? rule,
    String? requiredMessage,
  }) : super(
          initialValue: controller?.text ?? '',
          autovalidateMode: AutovalidateMode.disabled,
          validator: (v) {
            final t = (v ?? '').trim();
            if (t.isEmpty) {
              return isRequired
                  ? (requiredMessage ?? 'This field is required')
                  : null;
            }
            return rule?.call(t);
          },
          builder: (field) => (field as _AppTextFieldState)._buildField(),
        );

  @override
  FormFieldState<String> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends FormFieldState<String> {
  late final TextEditingController _c;
  late final bool _ownsController;
  final FocusNode _focus = FocusNode();
  bool _validated = false;
  bool _wasFocused = false;

  @override
  AppTextField get widget => super.widget as AppTextField;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _c = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focus.addListener(_onFocus);
  }

  void _onFocus() {
    if (_focus.hasFocus) {
      _wasFocused = true;
      setState(() {});
    } else if (_wasFocused) {
      validate(); // بيعمل setState جواه
    }
  }

  @override
  bool validate() {
    _validated = true;
    return super.validate();
  }

  @override
  void reset() {
    _validated = false;
    _c.text = widget.initialValue ?? '';
    super.reset();
  }

  void _onChanged(String v) {
    didChange(v);
    if (_validated) validate();
    widget.onChanged?.call(v);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _focus.dispose();
    if (_ownsController) _c.dispose();
    super.dispose();
  }

  Widget _buildField() {
    final hasError = errorText != null;
    final isValid = _validated && !hasError && _c.text.trim().isNotEmpty;
    final iconColor = hasError ? AppColors.red : AppColors.textDim;

    return LabeledField(
      label: widget.label,
      isRequired: widget.isRequired,
      error: errorText,
      helper: widget.helper,
      child: FieldBox(
        hasError: hasError,
        focused: _focus.hasFocus,
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(widget.prefixIcon, size: 16, color: iconColor),
              const Gap.h(10),
            ],
            Expanded(
              child: TextField(
                controller: _c,
                focusNode: _focus,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                maxLength: widget.maxLength,
                textDirection: widget.rtl ? TextDirection.rtl : null,
                cursorColor: AppColors.cyan,
                style: const TextStyle(fontSize: 12),
                onChanged: _onChanged,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  counterText: '',
                  hintText: widget.hint,
                  hintStyle:
                      const TextStyle(fontSize: 12, color: AppColors.textDim),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            if (hasError)
              const Icon(Icons.error_outline, size: 16, color: AppColors.red)
            else if (isValid)
              const Icon(Icons.check_circle_outline,
                  size: 16, color: AppColors.cyan),
          ],
        ),
      ),
    );
  }
}
