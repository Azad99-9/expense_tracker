import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:expense_tracker/view_model/home_calendar_screen_view_model.dart';
import 'package:expense_tracker/view_model/specific_day_view_model.dart';
import 'package:expense_tracker/views/home_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SpecificDayScreen extends StackedView<SpecificDayViewModel> {
  final CalendarTapDetails details;
  final HomeCalendarScreenViewModel homeViewModel;

  @override
  SpecificDayViewModel viewModelBuilder(BuildContext context) =>
      SpecificDayViewModel();

  @override
  void onViewModelReady(SpecificDayViewModel viewModel) {
    viewModel.intialise(details, homeViewModel);
  }

  const SpecificDayScreen({
    required this.details,
    required this.homeViewModel,
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
            '${dateTimeService.formatDate(model.currentDate, format: 'd MMMM, y')}'),
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
                                              categories: model.categories,
                                              initialCategory: expense.category,
                                              primaryAction: (category,
                                                  controller1,
                                                  controller2,
                                                  controller4) {
                                                model.editExpense(
                                                  index,
                                                  controller1.text,
                                                  double.parse(
                                                      controller2.text),
                                                  controller4.text,
                                                  category,
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
              categories: model.categories,
              initialCategory: model.categories[0],
              primaryAction: (category, controller1, controller2, controller4) {
                model.addExpense(
                  controller1.text,
                  double.parse(controller2.text),
                  category,
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
    required List<String> categories,
    required String initialCategory,
    required Function(String, TextEditingController, TextEditingController,
            TextEditingController)
        primaryAction,
    required Function() secondaryAction,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogWidget(
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
          categories: categories,
          initialCategory: initialCategory,
        );
      },
    );
  }
}

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({
    super.key,
    required this.title,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.inputLabel1,
    required this.inputLabel2,
    required this.inputLabel3,
    required this.inputLabel4,
    required this.initialCategory,
    required this.categories,
    required this.initialText1,
    required this.initialText2,
    required this.initialText3,
    required this.initialText4,
    required this.primaryAction,
    required this.secondaryAction,
  });

  final String title;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final String inputLabel1;
  final String inputLabel2;
  final String inputLabel3;
  final String inputLabel4;
  final String initialCategory;
  final List<String> categories;
  final String initialText1;
  final String initialText2;
  final String initialText3;
  final String initialText4;
  final Function(String, TextEditingController, TextEditingController,
      TextEditingController) primaryAction;
  final Function() secondaryAction;

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller4;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController(text: widget.initialText1);
    controller2 = TextEditingController(text: widget.initialText2);
    controller4 = TextEditingController(text: widget.initialText4);
    selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;

    return AlertDialog(
      backgroundColor: colorScheme.primary,
      title: Text(widget.title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                labelText: widget.inputLabel1,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
            TextField(
              controller: controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: widget.inputLabel2,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              selectedItemBuilder: (BuildContext context) {
                return widget.categories
                    .map((category) => Text(
                          category,
                          style: textScheme.bodyMedium!.copyWith(
                              color: Colors
                                  .white), // White color for selected item
                        ))
                    .toList();
              },
              items: widget.categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: textScheme.bodyMedium!
                              .copyWith(color: colorScheme.tertiary),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: InputDecoration(
                labelText: widget.inputLabel3,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary), // Label color
                border: InputBorder.none,
              ),
              dropdownColor: colorScheme.surface,
              style: textScheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold, // Making the selected label thick
              ),
            ),
            TextField(
              controller: controller4,
              decoration: InputDecoration(
                labelText: widget.inputLabel4,
                labelStyle: textScheme.bodyMedium!
                    .copyWith(color: colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.redAccent), // Use proper color
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            widget.secondaryActionLabel,
            style: textScheme.bodyLarge!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Colors.greenAccent), // Use proper color
          ),
          onPressed: () {
            widget.primaryAction(
              selectedCategory,
              controller1,
              controller2,
              controller4,
            );
          },
          child: Text(
            widget.primaryActionLabel,
            style: textScheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
