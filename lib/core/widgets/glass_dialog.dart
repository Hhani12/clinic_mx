import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';
import 'glass_container.dart';

class GlassDialog extends StatelessWidget {
  const GlassDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.icon,
    this.maxWidth = 460,
  });

  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final Widget? icon;
  final double maxWidth;

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    required Widget content,
    List<Widget>? actions,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => GlassDialog(
        title: title,
        content: content,
        actions: actions,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: GlassContainer(
          borderRadius: glass.cardRadius,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null || title != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 10),
                    ],
                    if (title != null)
                      Expanded(
                        child: DefaultTextStyle.merge(
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ) ??
                              const TextStyle(fontSize: 20),
                          child: title!,
                        ),
                      ),
                  ],
                ),
              if (icon != null || title != null) const SizedBox(height: 12),
              content,
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.end,
                  children: actions!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
