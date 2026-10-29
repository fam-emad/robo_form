import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';
import 'field_parts.dart';
import 'gap.dart';
import 'icon_text.dart';
import 'selectable_option.dart';
import 'spaced_column.dart';

/// صفين جنب بعض على الشاشة العريضة، وفوق بعض على الموبايل.
class FieldRow extends StatelessWidget {
  final List<Widget> children;
  const FieldRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth > 560) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) const Gap.h(16),
              Expanded(child: children[i]),
            ],
          ],
        );
      }
      return SpacedColumn(spacing: 16, children: children);
    });
  }
}

class FormSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const FormSection(
      {super.key, required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconText(
          icon: icon,
          iconSize: 13,
          iconColor: AppColors.cyan,
          label: AppText(title, 11, weight: FontWeight.w700),
        ),
        const Gap.v(8),
        const Divider(height: 1, color: AppColors.border),
        const Gap.v(16),
        child,
      ],
    );
  }
}

class ErrorBanner extends StatelessWidget {
  final String title;
  final String detail;
  const ErrorBanner({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return BorderedBox.tinted(
      tint: AppColors.red,
      fillOpacity: 0.08,
      borderOpacity: 0.7,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, size: 15, color: AppColors.red),
          const Gap.h(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title, 11,
                    weight: FontWeight.w700, color: AppColors.red),
                const Gap.v(3),
                AppText.muted(detail, 9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// قايمة منسدلة بنفس شكل AppTextField.
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T> onChanged;
  final IconData? prefixIcon;
  final String? helper;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.prefixIcon,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      helper: helper,
      child: FieldBox(
        child: Row(children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 16, color: AppColors.textDim),
            const Gap.h(10),
          ],
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                dropdownColor: AppColors.card,
                style: const TextStyle(fontSize: 12, color: Colors.white),
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 18, color: AppColors.textDim),
                items: [
                  for (final i in items)
                    DropdownMenuItem(value: i, child: Text(itemLabel(i))),
                ],
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

/// اختيار واحد من كذا (Yes / No مثلاً).
class AppRadioGroup<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final String Function(T) optionLabel;
  final T value;
  final ValueChanged<T> onChanged;

  const AppRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.optionLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      child: Row(
        children: [
          for (final o in options)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SelectableOption(
                selected: o == value,
                onTap: () => onChanged(o),
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(children: [
                  Icon(
                    o == value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 14,
                    color: o == value ? AppColors.cyan : AppColors.textDim,
                  ),
                  const Gap.h(8),
                  AppText(optionLabel(o), 11),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

class CommitteeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const CommitteeTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? color : AppColors.textDim;
    return SelectableOption(
      selected: selected,
      onTap: onTap,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Icon(selected ? Icons.check_box : Icons.check_box_outline_blank,
            size: 16, color: iconColor),
        const Gap.h(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, 11, weight: FontWeight.w700),
              const Gap.v(2),
              AppText.muted(subtitle, 8.5),
            ],
          ),
        ),
        Icon(icon, size: 16, color: iconColor),
      ]),
    );
  }
}
