import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings {
  const ThemeSettings({
    required this.themeMode,
    required this.locale,
    required this.blurIntensity,
    required this.animatedBackground,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final double blurIntensity;
  final bool animatedBackground;

  ThemeSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    double? blurIntensity,
    bool? animatedBackground,
  }) {
    return ThemeSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      animatedBackground: animatedBackground ?? this.animatedBackground,
    );
  }

  static const defaults = ThemeSettings(
    themeMode: ThemeMode.light,
    locale: Locale('ar'),
    blurIntensity: 18,
    animatedBackground: true,
  );
}

class ThemeController extends Notifier<ThemeSettings> {
  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale_code';
  static const _blurKey = 'blur_intensity';
  static const _animatedBackgroundKey = 'animated_background';

  @override
  ThemeSettings build() {
    _loadFromStorage();
    return ThemeSettings.defaults;
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = switch (prefs.getString(_themeKey)) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
    final localeCode = prefs.getString(_localeKey) ?? 'ar';
    final blur = prefs.getDouble(_blurKey) ?? 18;
    final animatedBackground = prefs.getBool(_animatedBackgroundKey) ?? true;
    state = state.copyWith(
      themeMode: mode,
      locale: Locale(localeCode),
      blurIntensity: blur,
      animatedBackground: animatedBackground,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    final prefs = await SharedPreferences.getInstance();
    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
      ThemeMode.light => 'light',
    };
    await prefs.setString(_themeKey, value);
  }

  Future<void> setLocale(Locale locale) async {
    state = state.copyWith(locale: locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  Future<void> setBlurIntensity(double intensity) async {
    state = state.copyWith(blurIntensity: intensity);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_blurKey, intensity);
  }

  Future<void> setAnimatedBackground(bool enabled) async {
    state = state.copyWith(animatedBackground: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_animatedBackgroundKey, enabled);
  }
}

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeSettings>(ThemeController.new);
