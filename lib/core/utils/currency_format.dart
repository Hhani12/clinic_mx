import 'package:intl/intl.dart';

class CurrencyFormat {
  const CurrencyFormat._();

  static final NumberFormat _iqdFormatter = NumberFormat.decimalPattern(
    'en_US',
  );

  static String iqd(num value) {
    final rounded = value.round();
    return '${_iqdFormatter.format(rounded)} IQD';
  }

  static double? parseLoose(String raw) {
    final cleaned = raw.replaceAll(',', '').trim();
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }
}
