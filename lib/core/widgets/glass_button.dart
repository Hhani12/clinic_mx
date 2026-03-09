import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

enum GlassButtonVariant { primary, secondary, neutral }

class GlassButton extends StatefulWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = false,
    this.variant = GlassButtonVariant.primary,
    this.height = 50,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;
  final GlassButtonVariant variant;
  final double height;

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final radius = BorderRadius.circular(glass.pillRadius);
    final enabled = widget.onPressed != null;

    final Gradient? gradient = switch (widget.variant) {
      GlassButtonVariant.primary => glass.buttonGradient,
      GlassButtonVariant.secondary => glass.secondaryButtonGradient,
      GlassButtonVariant.neutral => null,
    };

    final Color foreground = widget.variant == GlassButtonVariant.neutral
        ? Theme.of(context).colorScheme.onSurface
        : Colors.white;

    final Color? flatColor = widget.variant == GlassButtonVariant.neutral
        ? glass.surfaceStrong
        : null;

    final Color glowColor = switch (widget.variant) {
      GlassButtonVariant.primary => glass.primaryGlow,
      GlassButtonVariant.secondary => glass.secondaryGlow,
      GlassButtonVariant.neutral => glass.shadowColor.withValues(alpha: 0.2),
    };

    final shadowOpacity = !enabled
        ? 0.04
        : _pressed
            ? 0.1
            : _hovered
                ? 0.2
                : 0.14;

    final button = AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 120),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: widget.expanded ? double.infinity : null,
        height: widget.height,
        decoration: BoxDecoration(
          color: flatColor,
          gradient: gradient,
          borderRadius: radius,
          border: Border.all(color: glass.borderStrong, width: 0.9),
          boxShadow: [
            BoxShadow(
              color: glowColor.withValues(alpha: shadowOpacity),
              blurRadius: _hovered ? 20 : 14,
              spreadRadius: _hovered ? 1.2 : 0.1,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: widget.onPressed,
            onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
            onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
            onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 18, color: foreground),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: foreground,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) {
          setState(() {
            _hovered = false;
            _pressed = false;
          });
        },
        child: button,
      ),
    );
  }
}
