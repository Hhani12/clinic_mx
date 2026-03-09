import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme_tokens.dart';

class GlassTextField extends StatelessWidget {
  const GlassTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.pill = false,
    this.readOnly = false,
    this.enabled,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int maxLines;
  final int? minLines;
  final bool pill;
  final bool readOnly;
  final bool? enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final radius = pill ? glass.pillRadius : glass.controlRadius;
    final blur = glass.blurIntensity * 0.45;
    final borderRadius = BorderRadius.circular(radius);

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          focusNode: focusNode,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          enabled: enabled,
          autofocus: autofocus,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: glass.border,
                width: 0.9,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.4,
              ),
            ),
            filled: true,
            fillColor: glass.surface,
          ),
        ),
      ),
    );
  }
}
