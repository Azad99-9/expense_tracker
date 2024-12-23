import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/views/main_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:expense_tracker/view_model/monthly_summary_view_model.dart';

class MonthlySummaryScreen extends StackedView<MonthlySummaryViewModel> {
  DateTime currentDate;
  MonthlySummaryScreen({
    super.key,
    required this.currentDate,
  });

  @override
  MonthlySummaryViewModel viewModelBuilder(BuildContext context) =>
      MonthlySummaryViewModel();

  @override
  void onViewModelReady(MonthlySummaryViewModel model) {
    model.initialise(currentDate);
  }

  @override
  Widget builder(
      BuildContext context, MonthlySummaryViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(dateTimeService.getMonthYear(globalDate)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Monthly Total
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Expenses',
                      style: textScheme.titleMedium,
                    ),
                    Text(
                      '₹${model.monthlyTotal.toStringAsFixed(2)}',
                      style: textScheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Category-wise Chart
            Expanded(
              flex: 2,
              child: Card(
                elevation: 2,
                color: colorScheme.tertiary.withOpacity(0.2),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        title: 'Food',
                        color: Colors.blue,
                        radius: 60,
                      ),
                      PieChartSectionData(
                        value: 30,
                        title: 'Rent',
                        color: Colors.green,
                        radius: 60,
                      ),
                      PieChartSectionData(
                        value: 20,
                        title: 'Travel',
                        color: Colors.orange,
                        radius: 60,
                      ),
                      PieChartSectionData(
                        value: 10,
                        title: 'Others',
                        color: Colors.red,
                        radius: 60,
                      ),
                    ],
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 3,
              child: Card(
                elevation: 2,
                color: colorScheme.tertiary.withOpacity(0.2),
                child: ListView.builder(
                  itemCount: model.expenses.length,
                  itemBuilder: (context, index) {
                    final dayExpense = model.expenses[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.tertiary.withOpacity(0.3),
                        child: Text(
                          dayExpense.toString(),
                          style: textScheme.bodyMedium?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      // title: Text(
                      //   '₹${dayExpense.total.toStringAsFixed(2)}',
                      //   style: textScheme.bodyMedium,
                      // ),
                      // subtitle: Text(
                      //   'Expenses: ${dayExpense.expenseCount}',
                      //   style: textScheme.bodySmall,
                      // ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
