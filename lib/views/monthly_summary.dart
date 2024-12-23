import 'package:expense_tracker/constants/pie_colors.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/views/main_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:expense_tracker/view_model/monthly_summary_view_model.dart';

class MonthlySummaryScreen extends StackedView<MonthlySummaryViewModel> {
  final DateTime currentDate;
  const MonthlySummaryScreen({
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
                child: model.categories.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox,
                            color: colorScheme.onPrimary.withOpacity(0.5),
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Text(
                              'No expenses this month.',
                              textAlign: TextAlign.center,
                              style: textScheme.titleLarge!.copyWith(
                                  color:
                                      colorScheme.onPrimary.withOpacity(0.5)),
                            ),
                          )
                        ],
                      ))
                    : PieChart(
                        PieChartData(
                          sections: model.categories.entries
                              .toList()
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final category = entry.value.key;
                            final amount = entry.value.value;

                            return PieChartSectionData(
                              value: amount,
                              title: category,
                              color: pieColors[
                                  index], // Prevent out-of-bound errors
                              radius: 60,
                              titleStyle: textScheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // List of Daily Expenses
            Expanded(
              flex: 3,
              child: Card(
                elevation: 2,
                color: colorScheme.tertiary.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: model.categories.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              color: colorScheme.onPrimary.withOpacity(0.5),
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Text(
                                'No expenses this month.',
                                textAlign: TextAlign.center,
                                style: textScheme.titleLarge!.copyWith(
                                    color:
                                        colorScheme.onPrimary.withOpacity(0.5)),
                              ),
                            )
                          ],
                        ))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // Adjust the number of boxes per row
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio:
                                2, // Adjust the aspect ratio of each box
                          ),
                          itemCount: model.categories.length,
                          itemBuilder: (context, index) {
                            final entry =
                                model.categories.entries.elementAt(index);
                            final category = entry.key;
                            final amount = entry.value;

                            return Container(
                              decoration: BoxDecoration(
                                color: pieColors[index].withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorScheme.primary, width: 1),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category,
                                    style: textScheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onPrimary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₹${amount.toStringAsFixed(2)}',
                                    style: textScheme.bodyMedium?.copyWith(
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
