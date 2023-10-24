// Generic imports
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

// Backend imports
import 'package:mindwaves/backend/services/encryption_service.dart';
import 'package:mindwaves/backend/services/notification_service.dart';
import 'package:mindwaves/backend/services/settings_service.dart';

class TrackerService {
  final _masterBox = Hive.box('mindwaves');

  bool trackDay(int score, String? feeling, String? details) {
    //get an unique daily ID
    String id = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (_masterBox.get(id) != null) return false;

    String iv = '';
    if (details != null && details.isNotEmpty) {
      Map disposableMap = EncryptionService().encryptText(details);

      details = disposableMap.keys.first;
      iv = disposableMap.values.first;
    }

    _masterBox.put(
        id, {'score': score, 'feeling': feeling, 'details': details, 'iv': iv});

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
      NotificationService().scheduleNotification(
        id: 0,
        title: "Hey!",
        body: "Don't forget about tracking your day!",
        scheduledNotificationDateTime: notificationTime,
      );
    }

    return true;
  }

  bool deleteDay() {
    String id = DateFormat("yyyy-MM-dd").format(DateTime.now());
    if (_masterBox.containsKey(id)) {
      _masterBox.delete(id);
      return true;
    }
    return false;
  }

  Map<dynamic, dynamic> getData() {
    // Generate a map with decrypted details
    Map dataMap = _masterBox.toMap();
    Map factoryMap = {};

    dataMap.forEach((key, value) {
      if (value is Map) {
        if (value.keys.contains('iv') &&
            (value['details'] as String).isNotEmpty) {
          // is encrypted, has text

          String decryptedText =
              EncryptionService().decryptText(value['details'], value['iv']);
          factoryMap[key] = {
            'score': value['score'],
            'feeling': value['feeling'],
            'details': decryptedText,
          };
        } else {
          // no text, return just the score and plan details
          factoryMap[key] = {
            'score': value['score'],
            'feeling': value['feeling'],
            'details': value['details'],
          };
        }
      }
    });

    return factoryMap;
  }

  Box getDataMap() => _masterBox;
  void clearData() => _masterBox.clear();
}
