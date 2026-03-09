import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';
import 'glass_container.dart';

class GlassSegment<T> {
  const GlassSegment({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

class GlassSegmentedControl<T> extends StatelessWidget {
  const GlassSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedValue,
    required this.onChanged,
    this.expand = true,
  });

  final List<GlassSegment<T>> segments;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final radius = BorderRadius.circular(glass.pillRadius);
    final primary = Theme.of(context).colorScheme.primary;

    return GlassContainer(
      padding: const EdgeInsets.all(4),
      borderRadius: glass.pillRadius,
      blurSigma: glass.blurIntensity * 0.55,
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: segments.map((segment) {
          final selected = segment.value == selectedValue;
          final item = GestureDetector(
            onTap: () => onChanged(segment.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: selected
                    ? primary.withValues(alpha: 0.16)
                    : Colors.transparent,
                borderRadius: radius,
                border: selected
                    ? Border.all(
                        color: primary.withValues(alpha: 0.35),
                        width: 0.9,
                      )
                    : null,
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.15),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (segment.icon != null) ...[
                    Icon(
                      segment.icon,
                      size: 16,
                      color: selected ? primary : glass.textSecondary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    segment.label,
                    style: TextStyle(
                      color: selected ? primary : glass.textSecondary,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );

          if (!expand) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: item,
            );
          }
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: item,
            ),
          );
        }).toList(),
      ),
    );
  }
}
