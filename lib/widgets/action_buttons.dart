import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'app_text.dart';
import 'icon_text.dart';

// ════════════════════════════════════════════════════════════════
// PrimaryButton — مع hover/press scale animation
// ════════════════════════════════════════════════════════════════
class PrimaryButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? color;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.gradient,
    this.color,
    this.textColor = Colors.white,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      value: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.forward();
  void _onTapUp(_) => _ctrl.reverse();
  void _onTapCancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = widget.gradient ??
        (widget.color == null
            ? const LinearGradient(
                colors: [Color(0xFF35D0E6), Color(0xFF00B4D8)],
              )
            : null);

    final isCyanDefault = effectiveGradient != null && widget.color == null;
    final finalTextColor = isCyanDefault && widget.textColor == Colors.white
        ? const Color(0xFF070B12)
        : widget.textColor;

    final baseColor = widget.color ?? const Color(0xFF35D0E6);

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
            duration: const Duration(milliseconds: 160),
            height: 46,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
              gradient: effectiveGradient,
              boxShadow: [
                BoxShadow(
                  color: baseColor.withValues(
                    alpha: _hovered ? 0.40 : 0.25,
                  ),
                  blurRadius: _hovered ? 18 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: IconText(
                icon: widget.icon,
                iconSize: 16,
                iconColor: finalTextColor,
                iconAfter: true,
                label: AppText(widget.label, 12,
                    weight: FontWeight.w700, color: finalTextColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// OutlineActionButton — مع hover tint
// ════════════════════════════════════════════════════════════════
class OutlineActionButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const OutlineActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  @override
  State<OutlineActionButton> createState() => _OutlineActionButtonState();
}

class _OutlineActionButtonState extends State<OutlineActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.cyan.withValues(alpha: 0.06)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.cyan.withValues(alpha: 0.4) : AppColors.border,
            ),
          ),
          child: Center(
            child: IconText(
              icon: widget.icon,
              iconSize: 14,
              iconColor: _hovered ? AppColors.cyan : AppColors.textMuted,
              label: AppText(
                widget.label,
                11,
                color: _hovered ? AppColors.cyan : AppColors.textMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
