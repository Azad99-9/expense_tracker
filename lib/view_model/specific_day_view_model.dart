import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/models/expense/expense.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/view_model/home_calendar_screen_view_model.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SpecificDayViewModel extends BaseViewModel {
  late DateTime currentDate;
  List<Expense> expenses = [];
  late HomeCalendarScreenViewModel homeModel;
  late Box<Expenses> expensesBox;
  late final String expensesKey;

  final categories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Health',
    'Education',
    'Housing',
    'Utilities',
    'Insurance',
    'Savings',
    'Investments',
    'Debt Repayment',
    'Gifts',
    'Donations',
    'Personal Care',
    'Clothing',
    'Travel',
    'Subscriptions',
    'Miscellaneous',
    'Childcare',
    'Pets',
    'Dining Out',
    'Groceries',
    'Internet',
    'Phone',
    'Maintenance',
    'Taxes',
  ];

  bool isLoading = false;

  Future<void> intialise(CalendarTapDetails details,
      HomeCalendarScreenViewModel homeViewModel) async {
    isLoading = true;
    notifyListeners();

    currentDate = details.date!;
    expensesBox = await HiveService.openBox<Expenses>(HiveKeys.dayExpenses);
    expensesKey = details.date.toString();
    final Expenses? fetchedExpenses =
        HiveService.getItem<Expenses>(expensesBox, expensesKey);
    expenses = fetchedExpenses?.expenses ?? [];
    homeModel = homeViewModel;

    isLoading = false;
    notifyListeners();
  }

  // Adding a sample expense
  void addExpense(
      String title, double amount, String category, String description) {
    expenses.add(Expense(
      title: title,
      amount: amount,
      category: category,
      date: currentDate,
      description: description,
    ));
    updateDay();
    notifyListeners();
  }

  // Deleting an expense
  void deleteExpense(int index) {
    expenses.removeAt(index);
    updateDay();
    notifyListeners();
  }

  // Editing an expense
  void editExpense(int index, String title, double amount, String category,
      String description) {
    expenses[index] = Expense(
      title: title,
      amount: amount,
      category: category,
      date: currentDate,
      description: description,
    );
    updateDay();
    notifyListeners();
  }

  // Calculate total expenses
  double getTotalExpenses() {
    return expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  // Update the selected date and filter expenses
  void updateSelectedDate(DateTime newDate) {
    currentDate = newDate;
    expenses = expenses
        .where((expense) =>
            expense.date.year == currentDate.year &&
            expense.date.month == currentDate.month &&
            expense.date.day == currentDate.day)
        .toList();
    updateDay();
    notifyListeners();
  }

  void updateDay() {
    final newDay = Day(
      money: getTotalExpenses().toString(),
      expenses: expenses.take(3).map((el) => el.title).toList(),
      individualKey: currentDate.day.toString(),
    );
    homeModel.days
        .removeWhere((day) => day!.individualKey == currentDate.day.toString());
    homeModel.days.add(newDay);
  }

  @override
  void dispose() {
    HiveService.putItem<Expenses>(
      expensesBox,
      expensesKey,
      Expenses(expenses: expenses),
    );
    super.dispose();
  }
}
