import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

class GlassIconButton extends StatefulWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 42,
    this.iconSize = 20,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final double iconSize;
  final Color? color;

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

class _GlassIconButtonState extends State<GlassIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final blur = glass.blurIntensity * 0.45;
    final enabled = widget.onPressed != null;
    final primary = Theme.of(context).colorScheme.primary;
    final iconColor = widget.color ??
        Theme.of(context).iconTheme.color ??
        Theme.of(context).colorScheme.onSurface;

    Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered ? glass.surfaceStrong : glass.surface,
              border: Border.all(
                color: _hovered ? glass.borderStrong : glass.border,
                width: 0.9,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.16),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: enabled
                      ? iconColor
                      : iconColor.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }
    return button;
  }
}
