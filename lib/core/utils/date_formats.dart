import 'package:intl/intl.dart';

class DateFormats {
  const DateFormats._();

  static final DateFormat dayMonthYear = DateFormat('yyyy/MM/dd');
  static final DateFormat hourMinute = DateFormat('hh:mm a');
  static final DateFormat full = DateFormat('yyyy/MM/dd hh:mm a');
}
