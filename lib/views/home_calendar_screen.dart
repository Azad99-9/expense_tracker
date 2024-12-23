import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/view_model/home_calendar_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCalendarScreen extends StackedView<HomeCalendarScreenViewModel> {
  const HomeCalendarScreen({super.key});

  @override
  void onViewModelReady(HomeCalendarScreenViewModel model) {
    model.initialise();
  }

  @override
  HomeCalendarScreenViewModel viewModelBuilder(BuildContext context) =>
      HomeCalendarScreenViewModel();

  @override
  Widget builder(
      BuildContext context, HomeCalendarScreenViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(dateTimeService
            .getMonthYear(model.isLoading ? DateTime.now() : model.appBarDate)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: model.showInfo,
                  icon: Icon(
                    Icons.info_outline,
                    color: colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
                InkWell(
                  onTap: model.onTapCircleAvatar,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(userConfig.photoUrl),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SfCalendar(
        controller: model.calendarController,
        cellBorderColor: themeService.colorScheme.secondary.withOpacity(0.5),
        onViewChanged: (details) async {
          await model.onMonthChanged(
            details,
          );
        },
        onTap: model.onTapCell,
        monthCellBuilder: (BuildContext context, MonthCellDetails details) {
          DateTime date = details.date;

          bool isToday = DateTime.now().difference(date).inDays == 0 &&
              DateTime.now().day == date.day;

          bool currentMonth = model.belongsToCurrentMonth(details.date);

          Day? cellDay = model.days.firstWhere(
              (day) =>
                  currentMonth &&
                  day!.individualKey == details.date.day.toString(),
              orElse: () => null);

          List<String> dayExpenses = cellDay?.expenses ?? [];
          final symbol = model.evaluteSymbol(cellDay);
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.secondary.withOpacity(0.1), width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isToday ? Colors.blue : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(date.day.toString(),
                        style: textScheme.bodyMedium!.copyWith(
                          color: currentMonth
                              ? colorScheme.onPrimary
                              : colorScheme.onPrimary.withOpacity(0.3),
                          fontSize: currentMonth ? 12 : 10,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    child: ListView.builder(
                      itemCount: dayExpenses.length,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: model.evaluateColor(index, details.date.day),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          dayExpenses[index],
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: textScheme.bodySmall!.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                symbol == null
                    ? Container()
                    : Container(
                        width: 30,
                        height: 30,
                        child: symbol,
                      ),
              ],
            ),
          );
        },
        headerHeight: 0,
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: textScheme.bodyMedium,
        ),
        view: CalendarView.month,
      ),
    );
  }
}
