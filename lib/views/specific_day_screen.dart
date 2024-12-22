import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:expense_tracker/view_model/specific_day_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SpecificDayScreen extends StackedView<SpecificDayViewModel> {
  @override
  SpecificDayViewModel viewModelBuilder(BuildContext context) =>
      SpecificDayViewModel();
  @override
  Widget builder(
      BuildContext context, SpecificDayViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeService.primaryColor,
        title: Text('Expenses for ${model.selectedDate.toLocal()}'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: model.selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != model.selectedDate) {
                model.updateSelectedDate(pickedDate);
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: textScheme.bodyLarge?.copyWith(fontSize: 24),
                ),
                Text(
                  '₹ ${model.getTotalExpenses().toStringAsFixed(2)}',
                  style: textScheme.displayLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: model.expenses.isEmpty
                ? Center(child: Text('No expenses recorded for today.'))
                : ListView.builder(
                    itemCount: model.expenses.length,
                    itemBuilder: (context, index) {
                      var expense = model.expenses[index];
                      return Dismissible(
                        key: Key(expense.title),
                        onDismissed: (direction) {
                          model.deleteExpense(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${expense.title} deleted')));
                        },
                        background: Container(color: colorScheme.primary),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            tileColor: colorScheme.tertiary.withOpacity(0.3),
                            title: Text(
                              expense.title,
                              style: textScheme.bodyLarge,
                            ),
                            subtitle: Text(
                              '₹ ${expense.amount}',
                              style: textScheme.headlineSmall,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: colorScheme.onPrimary,
                              ),
                              onPressed: () {
                                // Edit expense logic
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController titleController =
                                        TextEditingController(
                                            text: expense.title);
                                    TextEditingController amountController =
                                        TextEditingController(
                                            text: expense.amount.toString());
                                    TextEditingController categoryController =
                                        TextEditingController(
                                            text: expense.category);

                                    return AlertDialog(
                                      title: Text('Edit Expense'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: InputDecoration(
                                                labelText: 'Title',
                                                labelStyle:
                                                    textScheme.bodyMedium),
                                          ),
                                          TextField(
                                            controller: amountController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: 'Amount',
                                                labelStyle:
                                                    textScheme.bodyMedium),
                                          ),
                                          TextField(
                                            controller: categoryController,
                                            decoration: InputDecoration(
                                                labelText: 'Category',
                                                labelStyle:
                                                    textScheme.bodyMedium),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: textScheme.bodyMedium,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            model.editExpense(
                                              index,
                                              titleController.text,
                                              double.parse(
                                                  amountController.text),
                                              categoryController.text,
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Save',
                                            style: textScheme.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // showCustomDialog(context, colorScheme, textScheme, model, 'Edit Expense');
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDialog(
              context: context,
              colorScheme: colorScheme,
              textScheme: textScheme,
              model: model,
              title: 'Add New Expense',
              primaryActionLabel: 'Add',
              secondaryActionLabel: 'Cancel',
              inputLabel1: 'Title',
              inputLabel2: 'Amount',
              inputLabel3: 'Category',
              primaryAction: (controller1, controller2, controller3) {
                model.addExpense(
                  controller1.text,
                  double.parse(controller2.text),
                  controller3.text,
                );
                navigationService.pop();
              },
              secondaryAction: () {
                navigationService.pop();
              });
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: colorScheme.tertiary.withOpacity(0.3),
      ),
    );
  }

  Future<dynamic> showCustomDialog({
    required BuildContext context,
    required ColorScheme colorScheme,
    required TextTheme textScheme,
    required SpecificDayViewModel model,
    required String title,
    required String primaryActionLabel,
    required String secondaryActionLabel,
    required String inputLabel1,
    required String inputLabel2,
    required String inputLabel3,
    required Function(
            TextEditingController, TextEditingController, TextEditingController)
        primaryAction,
    required Function() secondaryAction,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller1 = TextEditingController();
        TextEditingController controller2 = TextEditingController();
        TextEditingController controller3 = TextEditingController();
        return AlertDialog(
          backgroundColor: colorScheme.primary,
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller1,
                cursorColor: colorScheme.onPrimary,
                decoration: InputDecoration(
                    labelText: inputLabel1,
                    labelStyle: textScheme.bodyMedium,
                    border: InputBorder.none),
              ),
              TextField(
                controller: controller2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: inputLabel2, labelStyle: textScheme.bodyMedium),
              ),
              TextField(
                controller: controller3,
                decoration: InputDecoration(
                  labelText: inputLabel3,
                  labelStyle: textScheme.bodyMedium,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                secondaryActionLabel,
                style: textScheme.bodyLarge!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.successColor.withOpacity(0.3),
                ),
              ),
              onPressed: () {
                primaryAction(controller1, controller2, controller3);
              },
              child: Text(
                primaryActionLabel,
                style: textScheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}
