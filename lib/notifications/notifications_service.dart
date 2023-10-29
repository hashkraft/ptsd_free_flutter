import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> initializeNotification() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'high_importance_channel',
        channelKey: 'type1',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        onlyAlertOnce: true,
        playSound: true,
        criticalAlerts: true,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'high_importance_channel_group',
        channelGroupName: 'Group 1',
      )
    ],
    debug: true,
  );
  await AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );

  await AwesomeNotifications().setListeners(
    onActionReceivedMethod: onActionReceivedMethod,
    onNotificationCreatedMethod: onNotificationCreatedMethod,
    onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    onDismissActionReceivedMethod: onDismissActionReceivedMethod,
  );
}

/// Use this method to detect when a new notification or a schedule is created
Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification) async {
  debugPrint('onNotificationCreatedMethod');
}

/// Use this method to detect every time that a new notification is displayed
Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification) async {
  debugPrint('onNotificationDisplayedMethod');
}

/// Use this method to detect if the user dismissed a notification
Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction) async {
  debugPrint('onDismissActionReceivedMethod');
}

/// Use this method to detect when the user taps on a notification or action button
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  debugPrint('onActionReceivedMethod');
  final payload = receivedAction.payload ?? {};
  if (payload["navigate"] == "true") {
    print("notification was tapped!!!!");
  }
}

Future<void> scheduleNotification({
  required final String title,
  required final String body,
  required final TimeOfDay timeOfDay,
  required final int id,
  required int weekday,
  final String? summary,
  final Map<String, String>? payload,
  final ActionType actionType = ActionType.Default,
  final NotificationLayout notificationLayout = NotificationLayout.Default,
  final NotificationCategory? category,
  final String? bigPicture,
  final List<NotificationActionButton>? actionButtons,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: "type1",
      title: title,
      body: body,
      actionType: actionType,
      notificationLayout: notificationLayout,
      summary: summary,
      category: category,
      payload: payload,
      bigPicture: bigPicture,
    ),
    actionButtons: actionButtons,
    schedule: NotificationCalendar(
      weekday: weekday,
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: 0,
      repeats: true,
      allowWhileIdle: true,
    ),
  );
}
