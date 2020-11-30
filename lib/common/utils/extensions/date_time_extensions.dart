import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String yearMonthDay() {
    return DateFormat.yMMMMd().format(this);
  }

  String monthDayYear() {
    return DateFormat('MMMM dd, yyyy').format(this);
  }
}
