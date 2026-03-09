import 'package:flutter/material.dart';

import 'glass_segmented_control.dart';

class GlassTabBar extends StatelessWidget {
  const GlassTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<GlassTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final safeIndex = tabs.isEmpty ? 0 : selectedIndex.clamp(0, tabs.length - 1).toInt();
    return GlassSegmentedControl<int>(
      segments: List.generate(
        tabs.length,
        (index) => GlassSegment<int>(
          value: index,
          label: tabs[index].label,
          icon: tabs[index].icon,
        ),
      ),
      selectedValue: safeIndex,
      onChanged: onTap,
    );
  }
}

class GlassTab {
  const GlassTab({required this.label, this.icon});

  final String label;
  final IconData? icon;
}

