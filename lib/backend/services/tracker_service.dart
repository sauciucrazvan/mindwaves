// Generic imports
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class TrackerService {
  final _masterBox = Hive.box('mindwaves');

  bool trackDay(int score, String? details) {
    //get an unique daily ID
    String id = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (_masterBox.get(id) != null) return false;

    _masterBox.put(id, {'score': score, 'details': details});
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
    return _masterBox.toMap();
  }

  void clearData() => _masterBox.clear();
}
