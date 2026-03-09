import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class ThemeTokens {
  const ThemeTokens({
    required this.primaryBlue,
    required this.primaryGreen,
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.backgroundNeutral,
    required this.scaffoldBackground,
    required this.glassSurface,
    required this.glassSurfaceStrong,
    required this.glassSurfaceMuted,
    required this.glassBorder,
    required this.glassBorderStrong,
    required this.glassHighlight,
    required this.textPrimary,
    required this.textSecondary,
    required this.shadowColor,
    required this.buttonGradient,
    required this.secondaryButtonGradient,
    required this.blurIntensity,
    required this.cardRadius,
    required this.controlRadius,
    required this.pillRadius,
    required this.pagePadding,
  });

  final Color primaryBlue;
  final Color primaryGreen;
  final Color backgroundTop;
  final Color backgroundBottom;
  final Color backgroundNeutral;
  final Color scaffoldBackground;
  final Color glassSurface;
  final Color glassSurfaceStrong;
  final Color glassSurfaceMuted;
  final Color glassBorder;
  final Color glassBorderStrong;
  final Color glassHighlight;
  final Color textPrimary;
  final Color textSecondary;
  final Color shadowColor;
  final Gradient buttonGradient;
  final Gradient secondaryButtonGradient;
  final double blurIntensity;
  final double cardRadius;
  final double controlRadius;
  final double pillRadius;
  final double pagePadding;

  static ThemeTokens light({double blurIntensity = 18}) {
    return ThemeTokens(
      primaryBlue: const Color(0xFF6598EB),
      primaryGreen: const Color(0xFF148F5E),
      backgroundTop: const Color(0xFFF8FBFF),
      backgroundBottom: const Color(0xFFF3F7FC),
      backgroundNeutral: const Color(0xFFEFF4FA),
      scaffoldBackground: const Color(0xFFF4F8FD),
      glassSurface: Colors.white.withValues(alpha: 0.36),
      glassSurfaceStrong: Colors.white.withValues(alpha: 0.56),
      glassSurfaceMuted: const Color(0xFFEAF0F8).withValues(alpha: 0.62),
      glassBorder: Colors.white.withValues(alpha: 0.58),
      glassBorderStrong: Colors.white.withValues(alpha: 0.84),
      glassHighlight: Colors.white.withValues(alpha: 0.74),
      textPrimary: const Color(0xFF15263B),
      textSecondary: const Color(0xFF4E637A),
      shadowColor: const Color(0xFF102845).withValues(alpha: 0.14),
      buttonGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6598EB), Color(0xFF7DA7EE)],
      ),
      secondaryButtonGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF148F5E), Color(0xFF2FAA7A)],
      ),
      blurIntensity: blurIntensity,
      cardRadius: 26,
      controlRadius: 18,
      pillRadius: 999,
      pagePadding: 20,
    );
  }

  static ThemeTokens dark({double blurIntensity = 18}) {
    return ThemeTokens(
      primaryBlue: const Color(0xFF8AB4FF),
      primaryGreen: const Color(0xFF44C291),
      backgroundTop: const Color(0xFF0A1220),
      backgroundBottom: const Color(0xFF101B30),
      backgroundNeutral: const Color(0xFF0D1627),
      scaffoldBackground: const Color(0xFF08111F),
      glassSurface: Colors.white.withValues(alpha: 0.07),
      glassSurfaceStrong: Colors.white.withValues(alpha: 0.13),
      glassSurfaceMuted: Colors.white.withValues(alpha: 0.045),
      glassBorder: Colors.white.withValues(alpha: 0.2),
      glassBorderStrong: Colors.white.withValues(alpha: 0.3),
      glassHighlight: Colors.white.withValues(alpha: 0.24),
      textPrimary: const Color(0xFFEAF2FF),
      textSecondary: const Color(0xFFA7BAD7),
      shadowColor: Colors.black.withValues(alpha: 0.42),
      buttonGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6598EB), Color(0xFF7AA8FF)],
      ),
      secondaryButtonGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF148F5E), Color(0xFF3DB586)],
      ),
      blurIntensity: blurIntensity,
      cardRadius: 26,
      controlRadius: 18,
      pillRadius: 999,
      pagePadding: 20,
    );
  }
}

@immutable
class GlassThemeExtension extends ThemeExtension<GlassThemeExtension> {
  const GlassThemeExtension({
    required this.surface,
    required this.surfaceStrong,
    required this.surfaceMuted,
    required this.border,
    required this.borderStrong,
    required this.highlight,
    required this.shadowColor,
    required this.primaryGlow,
    required this.secondaryGlow,
    required this.blurIntensity,
    required this.cardRadius,
    required this.controlRadius,
    required this.pillRadius,
    required this.pagePadding,
    required this.backgroundGradient,
    required this.buttonGradient,
    required this.secondaryButtonGradient,
    required this.textSecondary,
  });

  factory GlassThemeExtension.fallback(Brightness brightness) {
    final tokens = brightness == Brightness.dark
        ? ThemeTokens.dark()
        : ThemeTokens.light();
    return GlassThemeExtension(
      surface: tokens.glassSurface,
      surfaceStrong: tokens.glassSurfaceStrong,
      surfaceMuted: tokens.glassSurfaceMuted,
      border: tokens.glassBorder,
      borderStrong: tokens.glassBorderStrong,
      highlight: tokens.glassHighlight,
      shadowColor: tokens.shadowColor,
      primaryGlow: tokens.primaryBlue.withValues(alpha: 0.24),
      secondaryGlow: tokens.primaryGreen.withValues(alpha: 0.18),
      blurIntensity: tokens.blurIntensity,
      cardRadius: tokens.cardRadius,
      controlRadius: tokens.controlRadius,
      pillRadius: tokens.pillRadius,
      pagePadding: tokens.pagePadding,
      backgroundGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [tokens.backgroundTop, tokens.backgroundBottom],
      ),
      buttonGradient: tokens.buttonGradient,
      secondaryButtonGradient: tokens.secondaryButtonGradient,
      textSecondary: tokens.textSecondary,
    );
  }

  final Color surface;
  final Color surfaceStrong;
  final Color surfaceMuted;
  final Color border;
  final Color borderStrong;
  final Color highlight;
  final Color shadowColor;
  final Color primaryGlow;
  final Color secondaryGlow;
  final double blurIntensity;
  final double cardRadius;
  final double controlRadius;
  final double pillRadius;
  final double pagePadding;
  final Gradient backgroundGradient;
  final Gradient buttonGradient;
  final Gradient secondaryButtonGradient;
  final Color textSecondary;

  @override
  ThemeExtension<GlassThemeExtension> copyWith({
    Color? surface,
    Color? surfaceStrong,
    Color? surfaceMuted,
    Color? border,
    Color? borderStrong,
    Color? highlight,
    Color? shadowColor,
    Color? primaryGlow,
    Color? secondaryGlow,
    double? blurIntensity,
    double? cardRadius,
    double? controlRadius,
    double? pillRadius,
    double? pagePadding,
    Gradient? backgroundGradient,
    Gradient? buttonGradient,
    Gradient? secondaryButtonGradient,
    Color? textSecondary,
  }) {
    return GlassThemeExtension(
      surface: surface ?? this.surface,
      surfaceStrong: surfaceStrong ?? this.surfaceStrong,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      highlight: highlight ?? this.highlight,
      shadowColor: shadowColor ?? this.shadowColor,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondaryGlow: secondaryGlow ?? this.secondaryGlow,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      cardRadius: cardRadius ?? this.cardRadius,
      controlRadius: controlRadius ?? this.controlRadius,
      pillRadius: pillRadius ?? this.pillRadius,
      pagePadding: pagePadding ?? this.pagePadding,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      secondaryButtonGradient:
          secondaryButtonGradient ?? this.secondaryButtonGradient,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<GlassThemeExtension> lerp(
    covariant ThemeExtension<GlassThemeExtension>? other,
    double t,
  ) {
    if (other is! GlassThemeExtension) {
      return this;
    }
    return GlassThemeExtension(
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceStrong:
          Color.lerp(surfaceStrong, other.surfaceStrong, t) ?? surfaceStrong,
      surfaceMuted:
          Color.lerp(surfaceMuted, other.surfaceMuted, t) ?? surfaceMuted,
      border: Color.lerp(border, other.border, t) ?? border,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t) ?? borderStrong,
      highlight: Color.lerp(highlight, other.highlight, t) ?? highlight,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t) ?? primaryGlow,
      secondaryGlow:
          Color.lerp(secondaryGlow, other.secondaryGlow, t) ?? secondaryGlow,
      blurIntensity: lerpDouble(blurIntensity, other.blurIntensity, t) ??
          blurIntensity,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t) ?? cardRadius,
      controlRadius:
          lerpDouble(controlRadius, other.controlRadius, t) ?? controlRadius,
      pillRadius: lerpDouble(pillRadius, other.pillRadius, t) ?? pillRadius,
      pagePadding: lerpDouble(pagePadding, other.pagePadding, t) ?? pagePadding,
      backgroundGradient:
          Gradient.lerp(backgroundGradient, other.backgroundGradient, t) ??
              (t < 0.5 ? backgroundGradient : other.backgroundGradient),
      buttonGradient: Gradient.lerp(buttonGradient, other.buttonGradient, t) ??
          (t < 0.5 ? buttonGradient : other.buttonGradient),
      secondaryButtonGradient:
          Gradient.lerp(
            secondaryButtonGradient,
            other.secondaryButtonGradient,
            t,
          ) ??
          (t < 0.5
              ? secondaryButtonGradient
              : other.secondaryButtonGradient),
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
    );
  }
}

extension GlassThemeContext on BuildContext {
  GlassThemeExtension get glassTheme {
    return Theme.of(this).extension<GlassThemeExtension>() ??
        GlassThemeExtension.fallback(Theme.of(this).brightness);
  }
}
