import 'package:intl/intl.dart';

class DateTimeService {
  /// Gets the current date and time as a DateTime object
  DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  /// Gets the current date in 'yyyy-MM-dd' format
  String getCurrentDateString() {
    DateTime currentDate = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(currentDate);
  }

  /// Gets the current time in 'HH:mm:ss' format
  String getCurrentTimeString() {
    DateTime currentTime = DateTime.now();
    return DateFormat('HH:mm:ss').format(currentTime);
  }

  /// Gets the name of the current month (e.g., 'January', 'February')
  String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  /// Formats a DateTime to a specific format (default is 'yyyy-MM-dd')
  String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  /// Converts a string date (e.g., '2023-12-21') to a DateTime object
  DateTime stringToDate(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  /// Gets the difference between two DateTime objects in days
  int getDaysDifference(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  /// Compares two DateTime objects and returns:
  /// -1 if the first date is earlier,
  /// 0 if they are the same,
  /// 1 if the first date is later.
  int compareDates(DateTime date1, DateTime date2) {
    if (date1.isBefore(date2)) {
      return -1;
    } else if (date1.isAfter(date2)) {
      return 1;
    } else {
      return 0;
    }
  }

  /// Gets the start of the current month (1st day of the month)
  DateTime getStartOfCurrentMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  /// Gets the end of the current month (last day of the month)
  DateTime getEndOfCurrentMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0); // Last day of the current month
  }

  /// Adds a specific number of days to the current date
  DateTime addDays(DateTime date, int daysToAdd) {
    return date.add(Duration(days: daysToAdd));
  }

  /// Subtracts a specific number of days from the current date
  DateTime subtractDays(DateTime date, int daysToSubtract) {
    return date.subtract(Duration(days: daysToSubtract));
  }

  /// Checks if a given date is today
  bool isToday(DateTime date) {
    DateTime today = DateTime.now();
    return date.year == today.year &&
           date.month == today.month &&
           date.day == today.day;
  }

  /// Checks if a given date is in the past
  bool isInThePast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Checks if a given date is in the future
  bool isInTheFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}
