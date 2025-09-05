import 'package:flutter/material.dart';
import 'package:language_translator/app/app.locator.dart';
import 'package:language_translator/app/app.router.dart';
import 'package:language_translator/services/hive_service.dart';
import 'package:language_translator/services/translator_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _translatorService = locator<TranslatorService>();
  final _navigationrService = locator<NavigationService>();

  final textController = TextEditingController();
  bool get isDarkMode => HiveService.getDarkMode();

  String _fromLang = 'English';
  String _toLang = 'Urdu';
  String _translatedText = '';
  bool _isLoading = false;

  // 🔥 Auto Translate flag (from Hive)
  bool get isAutoTranslate => HiveService.getAutoTranslate();

  String get fromLang => _fromLang;
  String get toLang => _toLang;
  String get translatedText => _translatedText;
  bool get isLoading => _isLoading;
  List<String> get availableLanguages => _translatorService.languages;

  HomeViewModel() {
    // Listen to Hive changes
    HiveService.listenToSettings().addListener(() {
      notifyListeners();
    });
  }

  void setFromLanguage(String? lang) {
    if (lang != null) {
      _fromLang = lang;
      notifyListeners();

      // 🔄 If Auto Translate is ON, translate immediately
      if (isAutoTranslate && textController.text.isNotEmpty) {
        translateText();
      }
    }
  }

  void setToLanguage(String? lang) {
    if (lang != null) {
      _toLang = lang;
      notifyListeners();

      if (isAutoTranslate && textController.text.isNotEmpty) {
        translateText();
      }
    }
  }

  Future<void> translateText() async {
    if (textController.text.trim().isEmpty) {
      _translatedText = "Please enter text to translate.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _translatorService.translateText(
      input: textController.text,
      fromLang: _fromLang,
      toLang: _toLang,
    );

    _translatedText = result;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> swapLanguages() async {
    final temp = _fromLang;
    _fromLang = _toLang;
    _toLang = temp;
    notifyListeners();

    if (isAutoTranslate && textController.text.isNotEmpty) {
      await translateText();
    }
  }

  void clearTranslation() {
    _translatedText = '';
    notifyListeners();
  }

  void openSettings() {
    _navigationrService.navigateToSettingsView();
  }
}
