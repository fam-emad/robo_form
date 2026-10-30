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

/// قسم في الفورم بعنوان وأيقونة — مع fade-in خفيف عند أول ظهور.
class FormSection extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const FormSection(
      {super.key, required this.icon, required this.title, required this.child});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    // نشغّل الانيميشن بعد أول frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconText(
              icon: widget.icon,
              iconSize: 13,
              iconColor: AppColors.cyan,
              label: AppText(widget.title, 11, weight: FontWeight.w700),
            ),
            const Gap.v(8),
            const Divider(height: 1, color: AppColors.border),
            const Gap.v(16),
            widget.child,
          ],
        ),
      ),
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

// ════════════════════════════════════════════════════════════════
// CommitteeTile — مع scale animation وhover effect
// ════════════════════════════════════════════════════════════════
class CommitteeTile extends StatefulWidget {
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
  State<CommitteeTile> createState() => _CommitteeTileState();
}

class _CommitteeTileState extends State<CommitteeTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      value: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    _scaleCtrl.forward();
  }

  void _onTapUp(_) {
    _scaleCtrl.reverse();
  }

  void _onTapCancel() {
    _scaleCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.selected ? widget.color : AppColors.textDim;
    final isActive = widget.selected || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: widget.selected
                  ? widget.color.withValues(alpha: 0.1)
                  : _hovered
                      ? widget.color.withValues(alpha: 0.05)
                      : AppColors.cardAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.selected
                    ? widget.color
                    : _hovered
                        ? widget.color.withValues(alpha: 0.4)
                        : AppColors.border,
                width: widget.selected ? 1.5 : 1.0,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.14),
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ]
                  : null,
            ),
            child: Row(children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.selected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  key: ValueKey(widget.selected),
                  size: 16,
                  color: iconColor,
                ),
              ),
              const Gap.h(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(widget.title, 11, weight: FontWeight.w700),
                    const Gap.v(2),
                    AppText.muted(widget.subtitle, 8.5),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                child: Icon(widget.icon, size: 16, color: iconColor),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
