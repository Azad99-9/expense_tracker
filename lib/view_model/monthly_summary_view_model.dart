import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/models/expense/expense.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class MonthlySummaryViewModel extends BaseViewModel {
  late DateTime currentDate;
  List<Expenses?> expenses = [];
  double monthlyTotal = 0.0;
  late Box<Expenses?> expensesBox;

  String get selectedMonthName => currentDate.month.toString();
  int get selectedYear => currentDate.year;

  void initialise(DateTime date) async {
    currentDate = date;
    expensesBox = await HiveService.openBox<Expenses>(HiveKeys.dayExpenses);
    await _fetchMonthlyExpenses();
  }

  Future<List<Expenses?>> getValuesForMonth() async {
    // Filter values for the specific month and year
    final filteredValues = expensesBox.keys
        .where((key) {
          final date = DateTime.tryParse(key); // Parse the key into DateTime
          return date != null &&
              date.year == currentDate.year &&
              date.month == currentDate.month;
        })
        .map((key) => HiveService.getItem<Expenses>(
            expensesBox, key)) // Get values for matching keys
        .toList();

    return filteredValues;
  }

  Future<void> _fetchMonthlyExpenses() async {
    expenses = await getValuesForMonth();
    // Example logic for fetching and aggregating expenses
    // Replace with actual Hive logic

    // monthlyTotal = expenses.fold(0.0, (sum, expense) => sum + expense.total);

    notifyListeners();
  }

  void onSelectMonth() {
    // Add logic to open a date picker and update `selectedDate`
    notifyListeners();
  }
}
