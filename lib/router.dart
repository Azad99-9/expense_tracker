import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/views/specific_day_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// A class to handle route generation throughout the app.
///
/// This class simplifies the management of named routes. Add routes in the
/// `generateRoute` method to map route names to their corresponding widgets.
///
/// Example:
/// ```
/// Navigator.pushNamed(context, '/details', arguments: {'id': 123});
/// ```
class AppRouter {
  /// Generates routes for the application based on route names.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.specificDay:
        return MaterialPageRoute(
            builder: (context) => SpecificDayScreen(
                  details: settings.arguments as CalendarTapDetails,
                ));
      default:
        // Fallback route for undefined routes.
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ),
        );
    }
  }
}
