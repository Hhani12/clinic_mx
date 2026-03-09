class Validators {
  const Validators._();

  static final RegExp _arabicNameRegex =
      RegExp(r'^[\u0621-\u064A][\u0621-\u064A\s\-]{1,30}$');
  static final RegExp _e164Regex = RegExp(r'^\+[1-9]\d{7,14}$');
  /// Iraqi local number: starts with 7, followed by 9 digits (total 10 digits).
  static final RegExp _iraqiLocalRegex = RegExp(r'^7\d{9}$');

  static String? requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required';
    }
    return null;
  }

  static String? arabicName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required';
    }
    final normalized = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (!_arabicNameRegex.hasMatch(normalized)) {
      return 'invalidArabicName';
    }
    return null;
  }

  static String? e164Phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required';
    }
    if (!_e164Regex.hasMatch(value.trim())) {
      return 'invalidPhone';
    }
    return null;
  }

  /// Validates the local part of an Iraqi phone number (without +964 prefix).
  /// Expects 10 digits starting with 7.
  static String? iraqiLocalPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required';
    }
    final cleaned = value.trim().replaceAll(RegExp(r'[^\d]'), '');
    if (!_iraqiLocalRegex.hasMatch(cleaned)) {
      return 'invalidPhone';
    }
    return null;
  }
}
