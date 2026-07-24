import 'package:intl/intl.dart';

class DateFormatter {
  static const List<String> monthsFull = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> weekdaysShort = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];

  /// Returns the number of days in the month for a given [date].
  static int daysInMonth(DateTime date) {
    final firstOfNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstOfNextMonth.subtract(const Duration(days: 1)).day;
  }

  /// Returns the starting weekday offset (0 = Sun, 1 = Mon, ..., 6 = Sat).
  static int firstWeekdayOfMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    return firstDay.weekday % 7;
  }

  /// Checks if two dates [a] and [b] represent the exact same calendar day.
  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Returns the short month name (e.g., 'Jan') for 1-indexed month number.
  static String getMonthShortName(int month) {
    if (month < 1 || month > 12) return '';
    return monthsShort[month - 1];
  }

  /// Returns the full month name (e.g., 'January') for 1-indexed month number.
  static String getMonthFullName(int month) {
    if (month < 1 || month > 12) return '';
    return monthsFull[month - 1];
  }

  /// Formats date to 'MMM d, yyyy' (e.g. May 16, 2026)
  static String formatShortDate(DateTime date) {
    return '${getMonthShortName(date.month)} ${date.day}, ${date.year}';
  }

  // July 23, 2026
  static String formatFullDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMMd().format(date.toLocal());
  }
}
