import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatAmount(num? amount) {
    if (amount == null) return '';

    // Check if the number has decimal places
    if (amount % 1 == 0) {
      return NumberFormat('#,##,##0').format(amount); // No decimal places
    } else {
      return NumberFormat('#,##,##0.00').format(amount); // Two decimal places
    }
  }
}
