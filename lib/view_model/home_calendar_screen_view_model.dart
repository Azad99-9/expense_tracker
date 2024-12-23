import 'package:expense_tracker/constants/alert_symbols.dart';
import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/constants/pie_colors.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/services/navigation_service.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:expense_tracker/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCalendarScreenViewModel extends BaseViewModel
    with WidgetsBindingObserver {
  final CalendarController calendarController = CalendarController();
  late DateTime appBarDate;
  late Box<Days> cellsBox;
  late List<Day?> days;
  late String daysKey;
  late double thresold;

  bool isLoading = false;

  bool belongsToCurrentMonth(DateTime date) => date.month == appBarDate.month;

  void initialise() async {
    isLoading = true;
    notifyListeners();

    appBarDate = DateTime.now();
    globalDate = appBarDate;
    daysKey = dateTimeService.formatDate(appBarDate, format: 'MM/yyyy');
    await getFromHive();
    thresold = 1000;

    isLoading = false;
    notifyListeners();
  }

  Future<void> onMonthChanged(
    ViewChangedDetails details,
  ) async {
    pushToHive();
    final visibleDates = details.visibleDates;
    final currentDate = visibleDates[15];
    appBarDate = currentDate;
    globalDate = appBarDate;
    daysKey = dateTimeService.formatDate(appBarDate, format: 'MM/yyyy');
    await getFromHive();
    notifyListeners();
  }

  void showInfo() {
    final context = NavigationService.navigatorKey.currentState!.context;

    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Symbols', style: textScheme.titleLarge),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1

                const SizedBox(height: 25),
                SymbolItem(Symbols.success, textScheme,
                    'Safe: Expenses within the limit'),
                const SizedBox(height: 20),

                SymbolItem(
                    Symbols.alert, textScheme, 'Alert: Approaching the limit'),
                const SizedBox(height: 20),

                SymbolItem(
                    Symbols.failure, textScheme, 'Danger: Limit exceeded'),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.errorColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',
                  style: textScheme.bodyLarge!.copyWith(
                    color: colorScheme.secondary,
                  )),
            ),
          ],
        );
      },
    );
  }

  Row SymbolItem(Widget icon, TextTheme textScheme, String text) {
    return Row(
      children: [
        SizedBox(width: 40, height: 40, child: icon),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: textScheme.bodyLarge)),
      ],
    );
  }

  Color evaluateColor(int index, int day) {
    if (day % 2 == 0) {
      if (index == 1) {
        return pieColors[0];
      } else if (index == 2) {
        return pieColors[3];
      } else {
        return pieColors[6];
      }
    } else {
      if (index == 1) {
        return pieColors[8];
      } else if (index == 2) {
        return pieColors[11];
      } else {
        return pieColors[15];
      }
    }
  }

  void onTapCircleAvatar() {}

  void onTapCell(CalendarTapDetails details) async {
    if (!belongsToCurrentMonth(details.date!)) return;
    await navigationService
        .pushNamed(Routes.specificDay, arguments: [details, this]);
    days.sort((a, b) => a!.individualKey.compareTo(b!.individualKey));
    pushToHive();
    notifyListeners();
  }

  void pushToHive() {
    HiveService.putItem<Days>(cellsBox, daysKey, Days(days: days));
  }

  Future<void> getFromHive() async {
    cellsBox = await HiveService.openBox<Days>(HiveKeys.expenseCells);
    final Days? fetchedDays = HiveService.getItem<Days>(cellsBox, daysKey);
    print(daysKey);
    print(fetchedDays?.days ?? []);
    days = fetchedDays?.days ?? [];
  }

  dynamic evaluteSymbol(Day? cellDay) {
    if (cellDay == null) {
      return null;
    } else {
      final money = double.parse(cellDay.money);
      if (money > thresold) {
        return Symbols.failure;
      } else if (thresold - money <= 200) {
        return Symbols.alert;
      } else if (cellDay.expenses.isNotEmpty) {
        return Symbols.success;
      }
      return null;
    }
  }
}
