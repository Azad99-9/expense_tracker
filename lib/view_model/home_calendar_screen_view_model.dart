import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCalendarScreenViewModel extends BaseViewModel {
  final CalendarController calendarController = CalendarController();
  late DateTime appBarDate;
  late final Box<Days> cellsBox;
  late final List<Day> days;
  late final String daysKey;

  bool belongsToCurrentMonth(DateTime date) => date.month == appBarDate.month; 

  void initialise() async {
    appBarDate = DateTime.now();
    // daysKey = dateTimeService.formatDate(appBarDate, format: 'MM/yyyy');
    // cellsBox = await HiveService.openBox<Days>(HiveKeys.expenseCells);
    // HiveService.getItem(cellsBox, daysKey);
  }

  void changeappBarMonth(DateTime month) {
    appBarDate = month;
    notifyListeners();
  }

  void onSearch() {

  }

  void onTapCircleAvatar() {

  }

  void onTapCell(CalendarTapDetails details) {
    if (!belongsToCurrentMonth(details.date!)) return;
    navigationService.pushNamed(Routes.specificDay, arguments: details);
  }
}