import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

class GlassChip extends StatelessWidget {
  const GlassChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
    this.selectedColor,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final activeColor = selectedColor ?? Theme.of(context).colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(glass.pillRadius),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: selected
                ? activeColor.withValues(alpha: 0.16)
                : glass.surface,
            borderRadius: BorderRadius.circular(glass.pillRadius),
            border: Border.all(
              color: selected
                  ? activeColor.withValues(alpha: 0.45)
                  : glass.border,
              width: 0.9,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.16),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected ? activeColor : glass.textSecondary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: selected ? activeColor : glass.textSecondary,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
