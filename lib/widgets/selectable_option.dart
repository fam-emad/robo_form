import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// خيار قابل للاختيار مع AnimatedContainer + hover effect.
class SelectableOption extends StatefulWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double? height;

  const SelectableOption({
    super.key,
    required this.selected,
    required this.onTap,
    required this.child,
    this.color = AppColors.cyan,
    this.padding = EdgeInsets.zero,
    this.height,
  });

  @override
  State<SelectableOption> createState() => _SelectableOptionState();
}

class _SelectableOptionState extends State<SelectableOption> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.selected || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: widget.height,
          padding: widget.padding,
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
                      color: widget.color.withValues(alpha: 0.12),
                      blurRadius: 8,
                      spreadRadius: 0,
                    )
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
