import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/views/specific_day_screen.dart';
import 'package:stacked/stacked.dart';

class SpecificDayViewModel extends BaseViewModel {
  DateTime selectedDate = DateTime.now();
  List<Expense> expenses = [];

  // Adding a sample expense
  void addExpense(String title, double amount, String category) {
    expenses.add(Expense(
      title: title,
      amount: amount,
      category: category,
      date: selectedDate,
    ));
    notifyListeners();
  }

  // Deleting an expense
  void deleteExpense(int index) {
    expenses.removeAt(index);
    notifyListeners();
  }

  // Editing an expense
  void editExpense(int index, String title, double amount, String category) {
    expenses[index] = Expense(
      title: title,
      amount: amount,
      category: category,
      date: selectedDate,
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
}
