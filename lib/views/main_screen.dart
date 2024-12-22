import 'package:expense_tracker/view_model/main_screen_view_model.dart';
import 'package:expense_tracker/views/home_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainScreen extends StackedView<MainScreenViewModel> {
  const MainScreen({super.key});

  @override
  MainScreenViewModel viewModelBuilder(BuildContext context) =>
      MainScreenViewModel();

  @override
  Widget builder(
      BuildContext context, MainScreenViewModel viewModel, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    return Scaffold(
      body: IndexedStack(
        children: [
          HomeCalendarScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeService.colorScheme.surface,
        selectedItemColor: colorScheme.secondary,
        unselectedItemColor: colorScheme.tertiary,
        items: [
        navBarItem(Icons.calendar_month, 'month'),
        navBarItem(Icons.summarize, 'summary')
      ]),
    );
  }

  BottomNavigationBarItem navBarItem(IconData icon, String label) => BottomNavigationBarItem(icon: Icon(icon,), label: label);
}
