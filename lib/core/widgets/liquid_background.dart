import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';
import '../theme/theme_tokens.dart';

class LiquidBackground extends StatefulWidget {
  const LiquidBackground({
    super.key,
    required this.child,
    this.animate = true,
  });

  final Widget child;
  final bool animate;

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassThemeExtension>();
    if (glass == null) {
      return ColoredBox(color: Theme.of(context).colorScheme.surface);
    }

    if (!widget.animate) {
      return DecoratedBox(
        decoration: BoxDecoration(gradient: glass.backgroundGradient),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + (t * 0.9), -1),
              end: Alignment(1 - (t * 0.9), 1),
              colors: _colorsFromGradient(glass.backgroundGradient),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _GlowOrb(
                alignment: Alignment(
                  -0.9 + 0.2 * math.sin(t * math.pi * 2),
                  -0.78,
                ),
                color: glass.primaryGlow,
                radius: 240,
              ),
              _GlowOrb(
                alignment: Alignment(
                  0.9,
                  -0.4 + 0.2 * math.cos(t * math.pi * 2),
                ),
                color: glass.secondaryGlow,
                radius: 190,
              ),
              _GlowOrb(
                alignment: Alignment(
                  -0.2 + 0.3 * math.cos(t * math.pi * 3),
                  0.9,
                ),
                color: glass.primaryGlow.withValues(alpha: 0.12),
                radius: 290,
              ),
              widget.child,
            ],
          ),
        );
      },
    );
  }

  List<Color> _colorsFromGradient(Gradient gradient) {
    if (gradient is LinearGradient) {
      return gradient.colors;
    }
    final fallback = ThemeTokens.light();
    return <Color>[fallback.backgroundTop, fallback.backgroundBottom];
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.alignment,
    required this.color,
    required this.radius,
  });

  final Alignment alignment;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: alignment,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.44),
                color.withValues(alpha: 0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ThemeSettingsX on ThemeSettings {
  bool get isArabic => locale.languageCode == 'ar';
}
