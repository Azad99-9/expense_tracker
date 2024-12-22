import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCalendarScreenViewModel extends BaseViewModel {
  final CalendarController calendarController = CalendarController();
  late DateTime appBarDate;

  void initialise() {
    appBarDate = DateTime.now();
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
    navigationService.pushNamed(Routes.specificDay);
  }
}