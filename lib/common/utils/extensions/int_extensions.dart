import 'package:intl/intl.dart';

extension IntExtensions on int {
  String formatAsCurrency() {
    final formatCurrency = NumberFormat.compactSimpleCurrency();
    return formatCurrency.format(this);
  }
}
