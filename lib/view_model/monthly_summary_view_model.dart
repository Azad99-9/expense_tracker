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
  Map<String, double> categories = {};
  List<int> colors = [];

  String get selectedMonthName => currentDate.month.toString();
  int get selectedYear => currentDate.year;

  void initialise(DateTime date) async {
    currentDate = date;
    expensesBox = await HiveService.openBox<Expenses>(HiveKeys.dayExpenses);
    await _fetchMonthlyExpenses();
  }

  Future<void> getValuesForMonth() async {
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

    for (final expenses in filteredValues) {
      for (final expense in expenses!.expenses) {
        // Update the sum for the category
        categories.update(
          expense.category,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }

    monthlyTotal = categories.values.fold(0.0, (sum, value) => sum + value);

    colors = List.generate(categories.length, (i) => i);
  }

  Future<void> _fetchMonthlyExpenses() async {
    await getValuesForMonth();
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
