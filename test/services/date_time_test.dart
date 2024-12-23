import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/date_time_service.dart';

void main() {
  group('DateTimeService', () {
    final dateTimeService = DateTimeService();

    test('getCurrentDateTime returns current DateTime', () {
      final now = DateTime.now();
      final result = dateTimeService.getCurrentDateTime();

      expect(result.year, equals(now.year));
      expect(result.month, equals(now.month));
      expect(result.day, equals(now.day));
    });

    test('getCurrentDateString returns date in yyyy-MM-dd format', () {
      final now = DateTime.now();
      final expectedDate = DateFormat('yyyy-MM-dd').format(now);

      final result = dateTimeService.getCurrentDateString();

      expect(result, equals(expectedDate));
    });

    test('getCurrentTimeString returns time in HH:mm:ss format', () {
      final now = DateTime.now();
      final expectedTime = DateFormat('HH:mm:ss').format(now);

      final result = dateTimeService.getCurrentTimeString();

      expect(result, equals(expectedTime));
    });

    test('getMonthName returns correct month name', () {
      final testDate = DateTime(2026, 12, 22);
      final expectedMonth = 'December 2026';

      final result = dateTimeService.getMonthYear(testDate);

      expect(result, equals(expectedMonth));
    });

    test('formatDate formats date correctly', () {
      final testDate = DateTime(2026, 12, 22);
      final expectedFormat = '22-12-2026';

      final result = dateTimeService.formatDate(testDate, format: 'dd-MM-yyyy');

      expect(result, equals(expectedFormat));
    });

    test('stringToDate converts string to DateTime', () {
      final dateString = '2026-12-22';
      final expectedDate = DateTime(2026, 12, 22);

      final result = dateTimeService.stringToDate(dateString);

      expect(result, equals(expectedDate));
    });

    test('getDaysDifference calculates difference in days', () {
      final startDate = DateTime(2026, 12, 20);
      final endDate = DateTime(2026, 12, 22);

      final result = dateTimeService.getDaysDifference(startDate, endDate);

      expect(result, equals(2));
    });

    test('compareDates compares two dates correctly', () {
      final earlierDate = DateTime(2026, 12, 20);
      final laterDate = DateTime(2026, 12, 22);

      expect(dateTimeService.compareDates(earlierDate, laterDate), equals(-1));
      expect(dateTimeService.compareDates(laterDate, earlierDate), equals(1));
      expect(dateTimeService.compareDates(earlierDate, earlierDate), equals(0));
    });

    test('getStartOfCurrentMonth returns first day of the month', () {
      final now = DateTime.now();
      final expectedDate = DateTime(now.year, now.month, 1);

      final result = dateTimeService.getStartOfCurrentMonth();

      expect(result, equals(expectedDate));
    });

    test('getEndOfCurrentMonth returns last day of the month', () {
      final now = DateTime.now();
      final nextMonth = DateTime(now.year, now.month + 1, 0);

      final result = dateTimeService.getEndOfCurrentMonth();

      expect(result, equals(nextMonth));
    });

    test('addDays adds days correctly', () {
      final testDate = DateTime(2026, 12, 20);
      final expectedDate = DateTime(2026, 12, 25);

      final result = dateTimeService.addDays(testDate, 5);

      expect(result, equals(expectedDate));
    });

    test('subtractDays subtracts days correctly', () {
      final testDate = DateTime(2026, 12, 20);
      final expectedDate = DateTime(2026, 12, 15);

      final result = dateTimeService.subtractDays(testDate, 5);

      expect(result, equals(expectedDate));
    });

    test('isToday checks if a date is today', () {
      final today = DateTime.now();

      expect(dateTimeService.isToday(today), isTrue);

      final notToday = DateTime(2023, 12, 22);
      expect(dateTimeService.isToday(notToday), isFalse);
    });

    test('isInThePast checks if a date is in the past', () {
      final pastDate = DateTime(2023, 12, 21);
      expect(dateTimeService.isInThePast(pastDate), isTrue);

      final futureDate = DateTime(2026, 12, 24);
      expect(dateTimeService.isInThePast(futureDate), isFalse);
    });

    test('isInTheFuture checks if a date is in the future', () {
      final futureDate = DateTime(2026, 12, 24);
      expect(dateTimeService.isInTheFuture(futureDate), isTrue);

      final pastDate = DateTime(2023, 12, 21);
      expect(dateTimeService.isInTheFuture(pastDate), isFalse);
    });
  });
}
