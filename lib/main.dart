/*
-----

  Mindwaves
  Fully open-source mood tracker with AI integration and real-time notifications to keep track of your life.

  Credits:
  Răzvan Sauciuc - main developer

-----
*/

// Generic imports
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

// Application handler
import 'package:mindwaves/backend/handlers/app_handler.dart';
import 'package:mindwaves/backend/services/notification_service.dart';

void main() async {
  await Hive.initFlutter(); // Initialize Hive for Flutter
  Hive.openBox("mindwaves"); // Open the Hive box that represents the app data
  Hive.openBox(
      "mindwaves_options"); // Open the Hive box that represents the app settings

  NotificationService()
      .requestPermission(); // Request permission to send notifications
  NotificationService().initNotifications(); // Initialize the notifications

  runApp(const Mindwaves());
}
