import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mindwaves/backend/services/settings_service.dart';
import 'package:timezone/data/latest.dart' as timezones;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterNotifications =
      FlutterLocalNotificationsPlugin();

  var notificationDetails = const NotificationDetails(
    // Android channel settings
    android: AndroidNotificationDetails(
      'mindwaves-app',
      'reminder',
      importance: Importance.max,
    ),
  );

  // Functions
  void requestPermission() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> initNotifications() async {
    timezones.initializeTimeZones(); // Initialize the timezones

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  Future showNotification({int id = 0, String? title, String? body}) async {
    return flutterNotifications.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      required DateTime scheduledNotificationDateTime}) async {
    return flutterNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local,
      ),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  String getNotificationTime() {
    if (SettingsService().getSettingValue("notification-time") is! Map) {
      return "21:00";
    }

    final Map<dynamic, dynamic> notificationTime =
        SettingsService().getSettingValue("notification-time");

    final String hour = notificationTime["hour"];
    final String minute = notificationTime["minute"];

    final String hourString = hour.padLeft(2, '0');
    final String minuteString = minute.padLeft(2, '0');

    return '$hourString:$minuteString';
  }

  void sendReminder() {
    SettingsService settingsService = SettingsService();
    if (settingsService.getSettingValue('disable-notifications') == false &&
        Platform.isAndroid) {
      int hour = 21, minute = 00;

      if (settingsService.getSettingValue("notification-time") is Map) {
        hour = settingsService.getSettingValue("notification-time")['hour'];
        minute = settingsService.getSettingValue("notification-time")['minute'];
      }

      DateTime today = DateTime.now(),
          notificationTime =
              DateTime(today.year, today.month, today.day, hour, minute)
                  .add(const Duration(days: 1));
      NotificationService()
          .scheduleNotification(
            id: 0,
            title: "Hey!",
            body: "Don't forget about tracking your day!",
            scheduledNotificationDateTime: notificationTime,
          )
          .catchError((error) => throw Exception(error));
    }
  }
}
