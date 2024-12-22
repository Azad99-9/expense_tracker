import 'package:flutter/material.dart';

/// A service for managing navigation using named routes.
///
/// This service provides methods for navigation tasks such as pushing,
/// replacing, clearing all routes, and returning to the previous screen,
/// exclusively through named routing.
///
/// ### Setup:
/// 1. Register named routes in `MaterialApp` or `CupertinoApp`.
/// ```
/// MaterialApp(
///   navigatorKey: NavigationService.navigatorKey,
///   routes: {
///     '/home': (context) => HomeScreen(),
///     '/details': (context) => DetailsScreen(),
///   },
/// );
/// ```
/// 2. Use the service methods for navigation.
///
/// ### Features:
/// - Push, replace, and clear navigation stack.
/// - Support for passing arguments with named routes.
/// - Safe navigation without requiring `BuildContext`.
///
/// Example:
/// ```
/// NavigationService.pushNamed('/details', arguments: {'id': 123});
/// ```
class NavigationService {
  /// A global key to access the navigator.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigates to a new screen using a named route.
  ///
  /// Parameters:
  /// - `routeName`: The name of the route to navigate to.
  /// - `arguments`: Optional arguments to pass to the route.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  /// Replaces the current screen with a new screen using a named route.
  ///
  /// Parameters:
  /// - `routeName`: The name of the route to navigate to.
  /// - `arguments`: Optional arguments to pass to the route.
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Clears the entire navigation stack and navigates to a new screen using a named route.
  ///
  /// Parameters:
  /// - `routeName`: The name of the route to navigate to.
  /// - `arguments`: Optional arguments to pass to the route.
  Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pops the current screen and optionally returns a value.
  ///
  /// Parameters:
  /// - `result`: The value to return to the previous screen.
  void pop<T>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  /// Pops until a specific route name is reached.
  ///
  /// Parameters:
  /// - `routeName`: The name of the route to pop back to.
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /// Checks if the navigator can pop.
  ///
  /// Returns:
  /// - `true` if there is a route to pop, otherwise `false`.
  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }
}
