import 'package:stacked/stacked.dart';
import 'package:language_translator/services/hive_service.dart';

class SettingsViewModel extends BaseViewModel {
  bool get isAutoTranslate => HiveService.getAutoTranslate();
  bool get isDarkMode => HiveService.getDarkMode();

  void toggleAutoTranslate(bool value) async {
    await HiveService.setAutoTranslate(value);
    notifyListeners();
  }

  void toggleDarkMode(bool value) async {
    await HiveService.setDarkMode(value);
    notifyListeners();
  }
}
