import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.borderRadius,
    this.blurSigma,
    this.borderColor,
    this.backgroundColor,
    this.gradient,
    this.glowColor,
    this.onTap,
    this.enableBlur = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final double? borderRadius;
  final double? blurSigma;
  final Color? borderColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? glowColor;
  final VoidCallback? onTap;
  final bool enableBlur;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final radius = borderRadius ?? glass.cardRadius;
    final blur = blurSigma ?? glass.blurIntensity;

    final content = Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          width: width,
          height: height,
          alignment: alignment,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? glass.surface,
            gradient: gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    glass.surfaceStrong,
                    glass.surface,
                  ],
                ),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? glass.border,
              width: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                color: glass.shadowColor,
                blurRadius: 26,
                offset: const Offset(0, 14),
              ),
              BoxShadow(
                color: (glowColor ?? glass.primaryGlow).withValues(alpha: 0.12),
                blurRadius: 20,
                spreadRadius: 0.4,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  glass.highlight,
                  glass.highlight.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0, 0.2, 0.48],
              ),
            ),
          ),
        ),
      ],
    );

    final clipped = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: enableBlur
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: content,
            )
          : content,
    );

    final wrapped = margin == null ? clipped : Padding(padding: margin!, child: clipped);
    if (onTap == null) return wrapped;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: wrapped,
      ),
    );
  }
}
