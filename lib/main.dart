/*
-----

  Mindwaves
  Fully open-source mood tracker with AI integration and real-time notifications to keep track of your life.

  Credits:
  Răzvan Sauciuc - main developer
  OpenAI's API - making it possible to generate AI Improvements 

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

  // Open the Hive box that represents the app data
  Hive.openBox("mindwaves");
  // Open the Hive box that stores the app settings
  Hive.openBox("mindwaves_options");
  // Open the Hive box that caches the AI Improvements
  Hive.openBox("mindwaves_improvements");

  // Request permission to send notifications as soon as the app starts
  NotificationService().requestPermission();
  // Initialize the notifications service in order to send notifications
  NotificationService().initNotifications();

  runApp(const Mindwaves());
}
