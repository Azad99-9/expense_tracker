import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/view_model/home_calendar_screen_view_model.dart';
import 'package:expense_tracker/views/home_calendar_screen.dart';
import 'package:expense_tracker/views/main_screen.dart';
import 'package:expense_tracker/views/signin_screen.dart';
import 'package:expense_tracker/views/signup_screen.dart';
import 'package:expense_tracker/views/specific_day_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      case Routes.homeCalendar:
        return MaterialPageRoute(builder: (context) => HomeCalendarScreen());

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (context) => MainScreen());

      case Routes.specificDay:
        final arguments = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) => SpecificDayScreen(
                  details: arguments[0] as CalendarTapDetails,
                  homeViewModel: arguments[1] as HomeCalendarScreenViewModel,
                ));

      case Routes.signIn:
        return MaterialPageRoute(builder: (context) => SignIn());

      case Routes.signUp:
        return MaterialPageRoute(
            builder: (context) => SignupScreen(
                  user: settings.arguments as User,
                ));

      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
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
