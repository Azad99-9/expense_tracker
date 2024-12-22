import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:expense_tracker/view_model/specific_day_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SpecificDayScreen extends StackedView<SpecificDayViewModel> {
  final CalendarTapDetails details;

  @override
  SpecificDayViewModel viewModelBuilder(BuildContext context) =>
      SpecificDayViewModel();

  @override
  void onViewModelReady(SpecificDayViewModel viewModel) {
    viewModel.intialise(details);
  }

  const SpecificDayScreen({
    required this.details,
  });

  

  @override
  Widget builder(
      BuildContext context, SpecificDayViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeService.primaryColor,
        title: Text(
            '${dateTimeService.formatDate(model.selectedDate, format: 'd MMMM, y')}'),
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
                  style: textScheme.bodyLarge
                      ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  '₹ ${model.getTotalExpenses().toStringAsFixed(2)}',
                  style: textScheme.displayLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: model.isLoading
                ? CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  )
                : model.expenses.isEmpty
                    ? Center(
                        child: Text('No expenses recorded for today.'),
                      )
                    : ListView.builder(
                        itemCount: model.expenses.length,
                        itemBuilder: (context, index) {
                          var expense = model.expenses[index];
                          return Dismissible(
                              key: Key(expense.title),
                              onDismissed: (direction) {
                                model.deleteExpense(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('${expense.title} deleted')));
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.delete_outline_outlined,
                                        color: colorScheme.error,
                                      ),
                                      Icon(
                                        Icons.delete_outline_outlined,
                                        color: colorScheme.error,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        colorScheme.tertiary.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Title and Subtitle
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 0),
                                              child: Text(
                                                expense.title,
                                                style: textScheme.bodyLarge,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '₹ ${expense.amount}',
                                                style: textScheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Trailing Icon
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: colorScheme.onPrimary,
                                          ),
                                          onPressed: () {
                                            showCustomDialog(
                                              context: context,
                                              colorScheme: colorScheme,
                                              textScheme: textScheme,
                                              model: model,
                                              title: 'Edit Expnese',
                                              primaryActionLabel: 'Save',
                                              secondaryActionLabel: 'Cancel',
                                              inputLabel1: 'Title',
                                              inputLabel2: 'Amount',
                                              inputLabel3: 'Category',
                                              inputLabel4: 'Description',
                                              initialText1: expense.title,
                                              initialText2:
                                                  expense.amount.toString(),
                                              initialText3: expense.category,
                                              initialText4: expense.description,
                                              primaryAction: (controller1,
                                                  controller2,
                                                  controller3,
                                                  controller4) {
                                                model.editExpense(
                                                  index,
                                                  controller1.text,
                                                  double.parse(
                                                      controller2.text),
                                                  controller3.text,
                                                  controller4.text,
                                                );
                                                navigationService.pop();
                                              },
                                              secondaryAction: () {
                                                navigationService.pop();
                                              },
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ));
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
              inputLabel4: 'Description',
              initialText1: '',
              initialText2: '',
              initialText3: '',
              initialText4: '',
              primaryAction:
                  (controller1, controller2, controller3, controller4) {
                model.addExpense(
                  controller1.text,
                  double.parse(controller2.text),
                  controller3.text,
                  controller4.text,
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
    required String inputLabel4,
    required String initialText1,
    required String initialText2,
    required String initialText3,
    required String initialText4,
    required Function(TextEditingController, TextEditingController,
            TextEditingController, TextEditingController)
        primaryAction,
    required Function() secondaryAction,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogWidget(
          context: context,
          colorScheme: colorScheme,
          textScheme: textScheme,
          model: model,
          title: title,
          primaryActionLabel: primaryActionLabel,
          secondaryActionLabel: secondaryActionLabel,
          inputLabel1: inputLabel1,
          inputLabel2: inputLabel2,
          inputLabel3: inputLabel3,
          inputLabel4: inputLabel4,
          initialText1: initialText1,
          initialText2: initialText2,
          initialText3: initialText3,
          initialText4: initialText4,
          primaryAction: primaryAction,
          secondaryAction: secondaryAction,
        );
      },
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  CustomDialogWidget({
    super.key,
    required this.context,
    required this.colorScheme,
    required this.textScheme,
    required this.model,
    required this.title,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.inputLabel1,
    required this.inputLabel2,
    required this.inputLabel3,
    required this.inputLabel4,
    required this.initialText1,
    required this.initialText2,
    required this.initialText3,
    required this.initialText4,
    required this.primaryAction,
    required this.secondaryAction,
  });

  final BuildContext context;
  final ColorScheme colorScheme;
  final TextTheme textScheme;
  final SpecificDayViewModel model;
  final String title;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final String inputLabel1;
  final String inputLabel2;
  final String inputLabel3;
  final String inputLabel4;
  final String initialText1;
  final String initialText2;
  final String initialText3;
  final String initialText4;
  final Function(TextEditingController, TextEditingController,
      TextEditingController, TextEditingController) primaryAction;
  final Function() secondaryAction;

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    controller1.text = initialText1;
    controller2.text = initialText2;
    controller3.text = initialText3;
    controller4.text = initialText4;
    return AlertDialog(
      backgroundColor: colorScheme.primary,
      title: Text(title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller1,
              cursorColor: colorScheme.onPrimary,
              decoration: InputDecoration(
                  labelText: inputLabel1,
                  labelStyle: textScheme.bodyMedium!
                      .copyWith(color: colorScheme.tertiary),
                  border: InputBorder.none),
            ),
            TextField(
              controller: controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: inputLabel2,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
            TextField(
              controller: controller3,
              decoration: InputDecoration(
                labelText: inputLabel3,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
            TextField(
              controller: controller4,
              decoration: InputDecoration(
                labelText: inputLabel4,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            navigationService.pop();
          },
          child: Text(
            secondaryActionLabel,
            style: textScheme.bodyLarge!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(colorScheme.error),
          ),
        ),
        TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.successColor,
            ),
          ),
          onPressed: () {
            primaryAction(controller1, controller2, controller3, controller4);
          },
          child: Text(
            primaryActionLabel,
            style: textScheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
