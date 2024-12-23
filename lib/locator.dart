import 'package:expense_tracker/services/date_time_service.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/services/navigation_service.dart';
import 'package:expense_tracker/services/notification_service.dart';
import 'package:expense_tracker/services/size_config.dart';
import 'package:expense_tracker/services/user_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

final SizeConfig sizeConfig = locator<SizeConfig>();
final NavigationService navigationService = locator<NavigationService>();
final DateTimeService dateTimeService = locator<DateTimeService>();
final UserConfig userConfig = locator<UserConfig>();
final HiveService hiveService = locator<HiveService>();
final NotificationService notificationService = locator<NotificationService>();

Future<void> setupLocator () async {
  locator.registerSingleton<SizeConfig>(SizeConfig());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<DateTimeService>(DateTimeService());
  locator.registerSingleton<UserConfig>(UserConfig());
  locator.registerSingleton<HiveService>(HiveService());
  locator.registerSingleton<NotificationService>(NotificationService());
}