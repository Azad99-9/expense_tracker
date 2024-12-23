import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCalendarScreenViewModel extends BaseViewModel {
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
    daysKey = dateTimeService.formatDate(appBarDate, format: 'MM/yyyy');
    await getFromHive();
    notifyListeners();
  }

  void onSearch() {}

  void onTapCircleAvatar() {}

  void onTapCell(CalendarTapDetails details) async {
    if (!belongsToCurrentMonth(details.date!)) return;
    await navigationService
        .pushNamed(Routes.specificDay, arguments: [details, this]);
    days.sort((a, b) => a!.individualKey.compareTo(b!.individualKey));
    notifyListeners();
  }

  void pushToHive() {
    HiveService.putItem<Days>(cellsBox, daysKey, Days(days: days));
  }

  Future<void> getFromHive() async {
    cellsBox = await HiveService.openBox<Days>(HiveKeys.expenseCells);
    final Days? fetchedDays = HiveService.getItem<Days>(cellsBox, daysKey);
    days = fetchedDays?.days ?? [];
  }

  dynamic evaluteSymbol(Day? cellDay) {
    if (cellDay == null) {
      return null;
    } else {
      final money = double.parse(cellDay.money);
      if (money > thresold) return SvgPicture.asset('assets/svgs/danger.svg');
      else if (thresold - money <= 200 ) return SvgPicture.asset('assets/svgs/alert.svg');
      else if (cellDay.expenses.length > 0) return SvgPicture.asset('assets/svgs/piggy.svg');
      return null;
    }
  }

  @override
  void dispose() {
    pushToHive();
    super.dispose();
  }
}
