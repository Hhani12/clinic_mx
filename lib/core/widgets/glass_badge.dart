import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

enum GlassBadgeType { info, success, warning, error }

class GlassBadge extends StatelessWidget {
  const GlassBadge({
    super.key,
    required this.label,
    this.type = GlassBadgeType.info,
    this.icon,
  });

  final String label;
  final GlassBadgeType type;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final (Color bgColor, Color fgColor) = switch (type) {
      GlassBadgeType.info => (
          colorScheme.primary.withValues(alpha: 0.15),
          colorScheme.primary,
        ),
      GlassBadgeType.success => (
          colorScheme.secondary.withValues(alpha: 0.16),
          colorScheme.secondary,
        ),
      GlassBadgeType.warning => (
          const Color(0xFFE2A440).withValues(alpha: 0.18),
          const Color(0xFFBF7A13),
        ),
      GlassBadgeType.error => (
          colorScheme.error.withValues(alpha: 0.16),
          colorScheme.error,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(glass.pillRadius),
        border: Border.all(color: fgColor.withValues(alpha: 0.3), width: 0.9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fgColor),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: fgColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
