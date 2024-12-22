import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/models/expense/expense.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SpecificDayViewModel extends BaseViewModel {
  DateTime selectedDate = DateTime.now();
  List<Expense> expenses = [];
  late Box<Expenses> expensesBox;
  late final String expensesKey;

  bool isLoading = false;

  Future<void> intialise(CalendarTapDetails details) async {
    isLoading = true;
    notifyListeners();
    expensesBox =
        await HiveService.openBox<Expenses>(HiveKeys.dayExpenses);
    expensesKey = details.date.toString();
    final Expenses? fetchedExpenses = HiveService.getItem<Expenses>(expensesBox, expensesKey);
    expenses = fetchedExpenses?.expenses ?? [];
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
      date: selectedDate,
      description: description,
    ));
    notifyListeners();
  }

  // Deleting an expense
  void deleteExpense(int index) {
    expenses.removeAt(index);
    notifyListeners();
  }

  // Editing an expense
  void editExpense(int index, String title, double amount, String category,
      String description) {
    expenses[index] = Expense(
      title: title,
      amount: amount,
      category: category,
      date: selectedDate,
      description: description,
    );
    notifyListeners();
  }

  // Calculate total expenses
  double getTotalExpenses() {
    return expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  // Update the selected date and filter expenses
  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    expenses = expenses
        .where((expense) =>
            expense.date.year == selectedDate.year &&
            expense.date.month == selectedDate.month &&
            expense.date.day == selectedDate.day)
        .toList();
    notifyListeners();
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
