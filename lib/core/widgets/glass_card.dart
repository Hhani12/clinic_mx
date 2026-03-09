import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';
import 'glass_container.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.blurIntensity,
    this.borderRadius,
    this.glowColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? blurIntensity;
  final double? borderRadius;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    return GlassContainer(
      padding: padding,
      margin: margin,
      onTap: onTap,
      borderRadius: borderRadius ?? glass.cardRadius,
      blurSigma: blurIntensity ?? glass.blurIntensity,
      glowColor: glowColor,
      child: child,
    );
  }
}
