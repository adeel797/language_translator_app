import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box _settingsBox;

  static Future<void> init() async {
    _settingsBox = await Hive.openBox('settingsBox');
  }

  // ----------------- Auto Translate -----------------
  static Future<void> setAutoTranslate(bool value) async {
    await _settingsBox.put('autoTranslate', value);
  }

  static bool getAutoTranslate() {
    return _settingsBox.get('autoTranslate', defaultValue: false);
  }

  // ----------------- Dark Mode -----------------
  static Future<void> setDarkMode(bool value) async {
    await _settingsBox.put('darkMode', value);
  }

  static bool getDarkMode() {
    return _settingsBox.get('darkMode', defaultValue: false);
  }

  // ----------------- Listen for changes -----------------
  static ValueListenable<Box> listenToSettings() {
    return _settingsBox.listenable();
  }
}
