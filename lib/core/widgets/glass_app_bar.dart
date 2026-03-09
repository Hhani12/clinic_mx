import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: glass.blurIntensity * 0.65,
          sigmaY: glass.blurIntensity * 0.65,
        ),
        child: AppBar(
          leading: leading,
          title: Text(title),
          actions: actions,
          backgroundColor: glass.surfaceStrong.withValues(alpha: 0.55),
          shadowColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: Border(
            bottom: BorderSide(color: glass.border, width: 0.8),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);
}
