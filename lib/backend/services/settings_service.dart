// Generic imports
import 'package:hive/hive.dart';

class SettingsService {
  final _settingsBox = Hive.box("mindwaves_options");

  dynamic getSettingValue(String setting) {
    if (_settingsBox.get(setting) != null) return _settingsBox.get(setting);
    return false;
  }

  void setSettingValue(String setting, dynamic value) {
    if (_settingsBox.get(setting) != null) _settingsBox.delete(setting);
    _settingsBox.put(setting, value);
  }

  // Reset to default values
  void resetSettings() => _settingsBox.clear();
}
