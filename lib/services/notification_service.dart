import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationService {


  Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'expense_tracker',
          channelKey: 'expense_tracker',
          channelName: 'expense_tracker',
          channelDescription: 'Notification channel for basic task',
          defaultColor: AppColors.primaryColor,
          ledColor: AppColors.errorColor,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'expense_tracker',
          channelGroupName: "expense_tracker",
        )
      ],
      debug: true,
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  @pragma('vm:entry-point')
  static void scheduleNotifications() {
    showNotification(body: 'Record your daily expenses!!!', title: 'Expense Tracker');
  }


  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("On Action Received");
    debugPrint("Payload: ${receivedAction.payload}");

    String? page = receivedAction.payload?['page']; // Check the 'page' key.
    debugPrint("Page to navigate: $page");

    if (page == 'menu') {
      navigationService
          .pushNamed(Routes.splashScreen); // Navigate to the menu screen.
    } else {
      debugPrint("No matching page found!");
    }
  }

  Future<void> onNotificationCreatedMethod(
      ReceivedNotification notification) async {
    debugPrint("On Notification Created Method");
  }

  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification recivedAction) async {
    debugPrint("On Notification Displayed");
  }

  Future<void> onDismissActionReceivedMethod(
      ReceivedAction recivedAction) async {
    debugPrint("On Notification Received");
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? summary,
    String? bigPicture,
  }) async {
    // Create the payload if you need to pass additional data
    final Map<String, String?> payload = {
      'title': title,
      'body': body,
      'summary': summary,
      'bigPicture': bigPicture,
    };

    // Create the notification
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0, // Notification ID, ensure it is unique for each notification
        channelKey: 'expense_tracker',
        title: title,
        body: body,
        summary: summary,
        bigPicture: bigPicture,
        notificationLayout: bigPicture != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.BigText,
        payload: payload,
      ),
    );
  }
}
