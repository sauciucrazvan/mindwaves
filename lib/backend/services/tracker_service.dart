// Generic imports
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

// Backend imports
import 'package:mindwaves/backend/services/encryption_service.dart';

class TrackerService {
  final _masterBox = Hive.box('mindwaves');

  bool trackDay(int score, String? details) {
    //get an unique daily ID
    String id = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (_masterBox.get(id) != null) return false;

    String iv = '';
    if (details != null && details.isNotEmpty) {
      Map disposableMap = EncryptionService().encryptText(details);

      details = disposableMap.keys.first;
      iv = disposableMap.values.first;
    }

    _masterBox.put(id, {'score': score, 'details': details, 'iv': iv});
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
        if (value.keys.contains('iv')) {
          // is encrypted, has text

          String decryptedText =
              EncryptionService().decryptText(value['details'], value['iv']);
          factoryMap[key] = {
            'score': value['score'],
            'details': decryptedText,
          };
        } else {
          // no text, return just the score and plan details
          factoryMap[key] = {
            'score': value['score'],
            'details': value['details']
          };
        }
      }
    });

    return factoryMap;
  }

  void clearData() => _masterBox.clear();
}