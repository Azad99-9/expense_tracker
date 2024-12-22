import 'package:flutter/widgets.dart';

/// A utility class for configuring responsive dimensions based on screen size.
///
/// This class facilitates the creation of responsive UI by providing proportional
/// width, height, aspect ratio, and safe area-aware dimensions.
///
/// ### Features:
/// - Dynamically calculates width, height, and font scaling.
/// - Provides aspect ratio and safe area handling.
/// - Supports edge padding for uniform and safe spacing.
///
/// ### Usage:
/// 1. Call `SizeConfig.init(context)` in the `build` method of the top-level widget.
/// 2. Use provided methods and properties for responsive design.
///
/// Example:
/// ```
/// SizeConfig.init(context);
/// double buttonWidth = SizeConfig.percentWidth(50); // 50% of screen width
/// double fontSize = SizeConfig.scaledTextSize(16);
/// double padding = SizeConfig.safePaddingTop;
/// ```
class SizeConfig {
  /// The width of the device screen.
  static late double screenWidth;

  /// The height of the device screen.
  static late double screenHeight;

  /// The device's aspect ratio.
  static late double aspectRatio;

  /// The scale factor for text, based on the device's default scaling.
  static late double textScaleFactor;

  /// The padding from the top safe area (e.g., for status bar).
  static late double safePaddingTop;

  /// The padding from the bottom safe area (e.g., for gesture navigation).
  static late double safePaddingBottom;

  /// Initializes the size configuration.
  ///
  /// This method must be called at the start of your app to configure the dimensions
  /// based on the device's screen size and safe areas.
  ///
  /// Parameters:
  /// - `context`: The `BuildContext` used to access the screen size and safe areas.
  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    aspectRatio = screenWidth / screenHeight;
    textScaleFactor = mediaQuery.textScaleFactor;

    safePaddingTop = mediaQuery.padding.top;
    safePaddingBottom = mediaQuery.padding.bottom;
  }

  /// Calculates the width as a percentage of the screen width.
  ///
  /// Parameters:
  /// - `percent`: The percentage of screen width (0-100).
  ///
  /// Returns:
  /// - The calculated width.
  static double percentWidth(double percent) {
    return screenWidth * (percent / 100);
  }

  /// Calculates the height as a percentage of the screen height.
  ///
  /// Parameters:
  /// - `percent`: The percentage of screen height (0-100).
  ///
  /// Returns:
  /// - The calculated height.
  static double percentHeight(double percent) {
    return screenHeight * (percent / 100);
  }

  /// Scales the given text size based on the device's text scale factor.
  ///
  /// Parameters:
  /// - `baseSize`: The base font size to scale.
  ///
  /// Returns:
  /// - The scaled font size.
  static double scaledTextSize(double baseSize) {
    return baseSize * textScaleFactor;
  }

  /// Provides the safe area height adjusted by the top and bottom paddings.
  ///
  /// Parameters:
  /// - `includeBottom`: Whether to include the bottom safe area padding.
  ///
  /// Returns:
  /// - The adjusted height.
  static double safeAreaHeight({bool includeBottom = true}) {
    final safePadding = includeBottom ? safePaddingTop + safePaddingBottom : safePaddingTop;
    return screenHeight - safePadding;
  }

  /// Calculates the size of an element based on the device's aspect ratio.
  ///
  /// Parameters:
  /// - `baseSize`: The base size to scale by the aspect ratio.
  ///
  /// Returns:
  /// - The adjusted size.
  static double sizeByAspectRatio(double baseSize) {
    return baseSize * aspectRatio;
  }

  /// Gets the width based on the safe area's horizontal padding.
  ///
  /// Returns:
  /// - The adjusted width.
  static double safeAreaWidth() {
    return screenWidth - MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.horizontal;
  }
}
