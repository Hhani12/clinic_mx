import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_controller.dart';
import 'theme_tokens.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData buildTheme({
    required Brightness brightness,
    required ThemeSettings settings,
  }) {
    final isDark = brightness == Brightness.dark;
    final tokens = isDark
        ? ThemeTokens.dark(blurIntensity: settings.blurIntensity)
        : ThemeTokens.light(blurIntensity: settings.blurIntensity);

    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: tokens.primaryBlue,
    ).copyWith(
      primary: tokens.primaryBlue,
      secondary: tokens.primaryGreen,
      surface: tokens.glassSurfaceStrong,
      onSurface: tokens.textPrimary,
      error: const Color(0xFFD54263),
      onError: Colors.white,
      outline: tokens.glassBorder,
      shadow: tokens.shadowColor,
    );

    final baseText = GoogleFonts.cairoTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(
      bodyColor: tokens.textPrimary,
      displayColor: tokens.textPrimary,
    );

    final glass = GlassThemeExtension(
      surface: tokens.glassSurface,
      surfaceStrong: tokens.glassSurfaceStrong,
      surfaceMuted: tokens.glassSurfaceMuted,
      border: tokens.glassBorder,
      borderStrong: tokens.glassBorderStrong,
      highlight: tokens.glassHighlight,
      shadowColor: tokens.shadowColor,
      primaryGlow: tokens.primaryBlue.withValues(alpha: isDark ? 0.22 : 0.25),
      secondaryGlow: tokens.primaryGreen.withValues(alpha: isDark ? 0.16 : 0.18),
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

    final radius = BorderRadius.circular(tokens.controlRadius);
    final cardRadius = BorderRadius.circular(tokens.cardRadius);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      splashFactory: InkSparkle.splashFactory,
      textTheme: baseText,
      dividerColor: tokens.glassBorder.withValues(alpha: 0.48),
      appBarTheme: AppBarTheme(
        backgroundColor: glass.surface.withValues(alpha: isDark ? 0.08 : 0.34),
        foregroundColor: tokens.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: baseText.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: tokens.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glass.surface,
        hintStyle: baseText.bodyMedium?.copyWith(
          color: tokens.textSecondary.withValues(alpha: 0.85),
        ),
        labelStyle: baseText.bodyMedium?.copyWith(
          color: tokens.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: glass.border, width: 0.9),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: glass.border, width: 0.9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: tokens.primaryBlue, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: colorScheme.error.withValues(alpha: 0.85),
            width: 1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: glass.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: cardRadius,
          side: BorderSide(color: glass.border, width: 0.9),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        selectedColor: colorScheme.primary,
        iconColor: tokens.textSecondary,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: glass.surfaceStrong.withValues(alpha: isDark ? 0.12 : 0.5),
        elevation: 0,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 22,
            color: selected ? colorScheme.primary : tokens.textSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return baseText.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? colorScheme.primary : tokens.textSecondary,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.35),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.controlRadius),
          ),
          textStyle: baseText.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tokens.textPrimary,
          side: BorderSide(color: glass.borderStrong, width: 0.9),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: baseText.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: baseText.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return tokens.textSecondary.withValues(alpha: 0.4);
            }
            return tokens.textPrimary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return glass.surfaceStrong;
            }
            if (states.contains(WidgetState.hovered)) {
              return glass.surface;
            }
            return Colors.transparent;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: colorScheme.primary,
        elevation: 0,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 18),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.pillRadius),
        ),
        side: BorderSide(color: glass.border, width: 0.8),
        selectedColor: colorScheme.primary.withValues(alpha: 0.15),
        backgroundColor: glass.surface,
        checkmarkColor: colorScheme.primary,
        labelStyle: baseText.labelMedium?.copyWith(
          color: tokens.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primary;
            }
            return tokens.textSecondary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primary.withValues(alpha: 0.12);
            }
            return glass.surface;
          }),
          side: WidgetStateProperty.all(
            BorderSide(color: glass.border, width: 0.8),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          textStyle: WidgetStateProperty.all(
            baseText.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withValues(alpha: 0.35);
          }
          return glass.surfaceMuted;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withValues(alpha: 0.22),
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.18),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: glass.surfaceStrong.withValues(alpha: isDark ? 0.13 : 0.56),
        modalBackgroundColor:
            glass.surfaceStrong.withValues(alpha: isDark ? 0.13 : 0.56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(tokens.cardRadius),
          ),
        ),
        showDragHandle: true,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: tokens.primaryBlue.withValues(alpha: 0.9),
        contentTextStyle: baseText.bodyMedium?.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      extensions: [glass],
    );
  }
}


