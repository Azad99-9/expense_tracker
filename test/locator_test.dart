import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/services/date_time_service.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/services/navigation_service.dart';
import 'package:expense_tracker/services/size_config.dart';
import 'package:expense_tracker/services/user_config.dart';
import 'package:expense_tracker/locator.dart';

void main() {
  // Clear the locator before each test to avoid any conflicts.
  setUp(() {
    locator.reset();
  });

  test('should register services in GetIt locator', () {
    // Act: Call the setupLocator to register services
    setupLocator();

    // Assert: Verify that the services are registered
    expect(locator.isRegistered<SizeConfig>(), true);
    expect(locator.isRegistered<NavigationService>(), true);
    expect(locator.isRegistered<DateTimeService>(), true);
    expect(locator.isRegistered<UserConfig>(), true);
    expect(locator.isRegistered<HiveService>(), true);  // Added HiveService check
  });

  test('should retrieve registered services from GetIt locator', () {
    // Act: Register the services using setupLocator
    setupLocator();

    // Assert: Verify that we can retrieve the registered services
    final sizeConfig = locator<SizeConfig>();
    final navigationService = locator<NavigationService>();
    final dateTimeService = locator<DateTimeService>();
    final userConfig = locator<UserConfig>();
    final hiveService = locator<HiveService>();  // Added HiveService retrieval

    expect(sizeConfig, isA<SizeConfig>());
    expect(navigationService, isA<NavigationService>());
    expect(dateTimeService, isA<DateTimeService>());
    expect(userConfig, isA<UserConfig>());
    expect(hiveService, isA<HiveService>());  // Check that HiveService is correctly registered
  });
}
