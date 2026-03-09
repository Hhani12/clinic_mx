import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';
import 'glass_text_field.dart';

class GlassSearchBar extends StatelessWidget {
  const GlassSearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.trailing,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? trailing;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final tr = hintText ?? 'Search...';
    final glass = context.glassTheme;

    return GlassTextField(
      controller: controller,
      hintText: tr,
      pill: true,
      autofocus: autofocus,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      prefixIcon: Icon(
        Icons.search_rounded,
        color: glass.textSecondary,
      ),
      suffixIcon: trailing,
      textInputAction: TextInputAction.search,
    );
  }
}
